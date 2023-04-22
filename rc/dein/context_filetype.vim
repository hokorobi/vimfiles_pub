" hook_source {{{
let g:context_filetype#filetypes = #{markdown: g:context_filetype#defaults#_filetypes.markdown}
call add(g:context_filetype#filetypes.markdown, #{
      \   start: '^\s*```\s*viml',
      \   end: '^\s*```$',
      \   filetype: 'vim',
      \ })
" [plugins.ftplugins] の書式にも対応するため設定上書き
let g:context_filetype#filetypes.toml = [#{
      \   start: '\w\+\s*=\s*\(''\{3}\|"\{3}\)',
      \   end: '\1',
      \   filetype: 'vim',
      \ }]

let g:context_filetype#ignore_patterns = #{
      \   toml: ['^\s*#\s*'],
      \ }
" }}}
