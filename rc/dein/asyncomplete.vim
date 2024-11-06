" hook_add {{{
" let g:asyncomplete_log_file = expand('~/_vim/.asyncomplete/asyncomplete.log')

" デフォルトでは asyncomplete を有効にしない
let g:asyncomplete_enable_for_all = 0

let g:asyncomplete_min_chars = 2

" ポップアップが表示され過ぎるのを避ける
let g:asyncomplete_popup_delay = 200

autocmd vimrc FileType autohotkey,cfg,gitcommit,go,javascript,plantuml,python,rst,snippet,toml,typescript,vim,vb,xsl call asyncomplete#enable_for_buffer()
" }}}
" hook_source {{{
" buffer
let g:asyncomplete_buffer_match_pattern = '\a\+$'

autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(
      \ asyncomplete#sources#buffer#get_source_options(#{
      \   name: 'buffer',
      \   priority: 5,
      \   allowlist: ['*'],
      \   blocklist: ['go', 'python'],
      \   completor: function('asyncomplete#sources#buffer#completor'),
      \ }))

" necosyntax
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(
      \ asyncomplete#sources#necosyntax#get_source_options(#{
      \   name: 'necosyntax',
      \   priority: 7,
      \   allowlist: ['autohotkey', 'javascript', 'plantuml', 'vb', 'vim'],
      \   completor: function('asyncomplete#sources#necosyntax#completor'),
      \ }))

" necovim
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(
      \ asyncomplete#sources#necovim#get_source_options(#{
      \   name: 'necovim',
      \   allowlist: ['vim'],
      \   priority: 10,
      \   completor: function('asyncomplete#sources#necovim#completor'),
      \ }))
" }}}
