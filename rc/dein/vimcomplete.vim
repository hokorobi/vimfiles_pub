" hook_add {{{
let g:vimcomplete_enable_by_default = v:false
let g:vimcomplete_do_mapping = v:false

let s:options = #{
      \ completor: #{
      \   shuffleEqualPriority: v:true,
      \   triggerWordLen: 2,
      \   showCmpSource: v:false,
      \ },
      \ buffer: #{
      \   enable: v:true,
      \   priority: 10,
      \   urlComplete: v:true,
      \   envComplete: v:true,
      \   dup: v:false,
      \   filetypes: ['autohotkey', 'cfg', 'gitcommit', 'javascript', 'markdown', 'plantuml', 'rst', 'snippet', 'python', 'toml', 'vim', 'xsl'],
      \ },
      \ dictionary: #{
      \   enable: v:true,
      \   priority: 11,
      \   matcher: 'ignorecase',
      \   properties: #{
      \     autohotkey: #{
      \       sortedDict: v:false,
      \       onlyWords: v:true,
      \     },
      \     plantuml: #{
      \       sortedDict: v:false,
      \       onlyWords: v:true,
      \     },
      \   },
      \   filetypes: ['autohotkey', 'plantuml'],
      \ },
      \ lsp: #{
      \   enable: v:true,
      \   priority: 9,
      \   maxCount: 5,
      \   filetypes: ['go', 'python', 'toml', 'typescript'],
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
" autohotkey {{{
setlocal dictionary=~/vimfiles/rc/ddc/autohotkey.txt
" }}}
" plantuml {{{
setlocal dictionary=~/vimfiles/rc/ddc/plantuml.txt
" }}}
