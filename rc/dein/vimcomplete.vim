" hook_add {{{
let g:vimcomplete_enable_by_default = v:false
let g:vimcomplete_do_mapping = v:false

let s:options = #{
      \ completor: #{
      \   shuffleEqualPriority: v:true,
      \   postfixHighlight: v:true,
      \   triggerWordLen: 2,
      \   showSource: v:false,
      \ },
      \ buffer: #{
      \   enable: v:true,
      \   priority: 10,
      \   urlComplete: v:true,
      \   envComplete: v:true,
      \   filetypes: ['autohotkey', 'cfg', 'gitcommit', 'javascript', 'markdown', 'plantuml', 'rst', 'snippet', 'python', 'toml', 'vim', 'xsl'],
      \ },
      \ lsp: #{
      \   enable: v:true,
      \   priority: 10,
      \   maxCount: 5,
      \   filetypes: ['go', 'python', 'toml', 'typescript'],
      \ },
      \ omnifunc: #{
      \   enable: v:false,
      \   priority: 8,
      \   filetypes: ['plantuml'],
      \ },
      \ vsnip: #{
      \   enable: v:true,
      \   priority: 11,
      \   filetypes: ['go', 'plantuml', 'rst', 'vim'],
      \ },
      \ vimscript: #{
      \   enable: v:true,
      \   priority: 9,
      \ },
      \}

autocmd vimrc VimEnter * call g:VimCompleteOptionsSet(s:options)
autocmd vimrc VimEnter * VimCompleteEnable autohotkey cfg gitcommit go javascript markdown plantuml python rst snippet toml typescript vim xsl
" }}}
