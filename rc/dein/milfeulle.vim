" hook_add {{{
" バッファ単位で移動位置を保存
let g:milfeulle_default_kind = 'buffer'
" 位置の保存は CursorMoved
let g:milfeulle_enable_CursorHold = 0
let g:milfeulle_enable_InsertLeave = 0
autocmd vimrc CursorMoved * MilfeulleOverlay

nnoremap <C-Left> <Plug>(milfeulle-prev)
nnoremap <C-Right> <Plug>(milfeulle-next)
" }}}
