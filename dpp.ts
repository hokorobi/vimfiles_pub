import {
  type ContextBuilder,
  type ExtOptions,
  type Plugin,
} from "jsr:@shougo/dpp-vim@~3.0.0/types";
import {
  BaseConfig,
  type ConfigReturn,
  type MultipleHook,
} from "jsr:@shougo/dpp-vim@~3.0.0/config";
import { Protocol } from "jsr:@shougo/dpp-vim@~3.0.0/protocol";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~3.0.0/utils";
import type {
  Ext as TomlExt,
  Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml@~1.3.0";

import type {
  Ext as LazyExt,
  LazyMakeStateResult,
  Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~1.5.0";

import type { Denops } from "jsr:@denops/std@~7.1.0";

import { expandGlob } from "jsr:@std/fs@~1.0.0/expand-glob";


export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
  }): Promise<ConfigReturn> {

    args.contextBuilder.setGlobal({
      extParams: {
        installer: {
          checkDiff: true,
          logFilePath: "~/.cache/dpp/installer-log.txt",
          githubAPIToken: Deno.env.get("GITHUB_API_TOKEN"),
        },
      },
      protocols: ["git"],
      skipMergeFilenamePattern: "^Gemfile$|^LICENSE|^lua$|^Makefile$|^t$|^test$|^tags(?:-\\w\\w)?$|^\\..+$|\\.\(gif|md|png\)$",
    });

    const [context, options] = await args.contextBuilder.get(args.denops);
    const protocols = await args.denops.dispatcher.getProtocols() as Record<
      string,
      Protocol
    >;

    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    const baseDir = "~/vimfiles/rc/dein/";
    let multipleHooks: MultipleHook[] = [];

    const [tomlExt, tomlOptions, tomlParams]: [
      TomlExt | undefined,
      ExtOptions,
      TomlParams,
    ] = await args.denops.dispatcher.getExt(
      "toml",
    ) as [TomlExt | undefined, ExtOptions, TomlParams];
    if (tomlExt) {
      const action = tomlExt.actions.load;


      const tomlPromises = [
        { path: baseDir + "_plugins.toml" },
        { path: baseDir + "_ddc.toml" },
        { path: baseDir + "_ddu.toml" },
        { path: baseDir + "_dpp.toml" },
      ].map((tomlFile) =>
        action.callback({
          denops: args.denops,
          context,
          options,
          protocols,
          extOptions: tomlOptions,
          extParams: tomlParams,
          actionParams: {
            path: tomlFile.path,
          },
        })
      );

      const tomls = await Promise.all(tomlPromises);

      // Merge toml results
      for (const toml of tomls) {
        for (const plugin of toml.plugins ?? []) {
          recordPlugins[plugin.name] = plugin;
        }

        if (toml.ftplugins) {
          mergeFtplugins(ftplugins, toml.ftplugins);
        }

        if (toml.multiple_hooks) {
          multipleHooks = multipleHooks.concat(toml.multiple_hooks);
        }

        if (toml.hooks_file) {
          hooksFiles.push(toml.hooks_file);
        }
      }
    }

    const [lazyExt, lazyOptions, lazyParams]: [
      LazyExt | undefined,
      ExtOptions,
      LazyParams,
    ] = await args.denops.dispatcher.getExt(
      "lazy",
    ) as [LazyExt | undefined, ExtOptions, LazyParams];
    let lazyResult: LazyMakeStateResult | undefined = undefined;
    if (lazyExt) {
      const action = lazyExt.actions.makeState;

      lazyResult = await action.callback({
        denops: args.denops,
        context,
        options,
        protocols,
        extOptions: lazyOptions,
        extParams: lazyParams,
        actionParams: {
          plugins: Object.values(recordPlugins),
        },
      });
    }

    const checkFiles = [];
    for await (const file of expandGlob(baseDir+"/*")) {
      checkFiles.push(file.path);
    }

    return {
      checkFiles,
      ftplugins,
      hooksFiles,
      multipleHooks,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
