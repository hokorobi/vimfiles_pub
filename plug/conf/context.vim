" hook_add {{{
call extend(g:vimrc_altercmd_dic, #{conte: 'ContextActivate|ContextEnable'})

"cheatsheet-echo
call cheatsheetecho#CheatSheetEchoAdd([':ContextActivate	でかい関数を読むときに見やすくなるかも'], '_', 'context')
" }}}
" hook_source {{{
let g:context_filetype_blacklist = ['floaterm']
" }}}
