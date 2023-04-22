" hook_add {{{
call extend(g:vimrc_altercmd_dic, {
      \   'cap[ture]': 'Capture',
      \ })
" }}}
" hook_source {{{
let g:capture_override_buffer = 'replace'

" Sayonara
let g:sayonara_filetypes.capture = 'bdelete'
" }}}
