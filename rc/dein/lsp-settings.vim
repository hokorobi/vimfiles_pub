" hook_add {{{
let g:lsp_settings_servers_dir = expand('~/_vim/lspservers')
let g:lsp_settings = {}
" https://github.com/tsuyoshicho/vimrc-reading/blob/ad6df8bdac68ccbba4c0457797a1f9db56fcdca1/.vim/rc/dein.toml#L2928-L2941
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
  \}
let g:lsp_settings['deno'] = #{
  \  blocklist: ['javascript'],
  \}
let g:lsp_settings_enable_suggestions = 0
" }}}
