" hook_add {{{
let g:lsp_settings_servers_dir = expand('~/_vim/lspservers')
let g:lsp_settings = {}
" https://github.com/tsuyoshicho/vimrc-reading/blob/ad6df8bdac68ccbba4c0457797a1f9db56fcdca1/.vim/rc/dein.toml#L2928-L2941
" https://github.com/raa0121/dotfiles/blob/f73d5fce976de96929fe7c7f6ed13f643af4281c/dein.toml#L287-L327
let g:lsp_settings['gopls'] = #{
  \  workspace_config: #{
  \    usePlaceholders: v:true,
  \    analyses: #{
  \      fillstruct: v:true,
  \    },
  \  },
  \  initialization_options: #{
  \    usePlaceholders: v:true,
  \    analyses: #{
  \      fillstruct: v:true,
  \    },
  \  },
  \  capabilities: #{
  \    textDocument: #{
  \      completion: #{
  \        completionItem: #{
  \          documentationFormat: ['markdown', 'plaintext'],
  \          snippetSupport: v:true,
  \          commitCharactersSupport: v:true,
  \          deprecatedSupport: v:true,
  \          preselectSupport: v:true,
  \          tagSupport: #{valueSet: [1]},
  \          insertReplaceSupport: v:true,
  \          resolveSupport: #{
  \            properties: [
  \              'documentation',
  \              'detail',
  \              'additionalTextEdits',
  \              'insertText',
  \              'textEdit',
  \              'insertTextFormat',
  \              'insertTextMode',
  \            ],
  \          },
  \          insertTextModeSupport: #{valueSet: [1, 2]},
  \          labelDetailsSupport: v:true,
  \        },
  \        contextSupport: v:true,
  \        insertTextMode: 1,
  \        completionList: #{itemDefaults: ['commitCharacters', 'editRange', 'insertTextFormat', 'insertTextMode', 'data']},
  \        completionItemKind: #{valueSet: [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 1, 2, 3, 4, 5, 6, 7, 8, 9]},
  \        dynamicRegistration: v:false,
  \      },
  \    },
  \  },
  \}
let g:lsp_settings['deno'] = #{
  \  blocklist: ['javascript'],
  \}
let g:lsp_settings_enable_suggestions = 0
" }}}
