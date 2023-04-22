" hook_add {{{
noremap <expr> qq printf('<Cmd>%s<CR>', &diff ? 'diffoff' : 'call sayonara#sayonara(v:true)')
" }}}
" hook_source {{{
let g:sayonara_filetypes.qf = 'bdelete'
let g:sayonara_filetypes.help = 'bdelete!'
" }}}
