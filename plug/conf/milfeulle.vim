" hook_add {{{
" バッファ単位で移動位置を保存
let g:milfeulle_default_kind = 'buffer'
" 位置の保存は CursorMoved
let g:milfeulle_enable_CursorHold = 0
let g:milfeulle_enable_InsertLeave = 0
autocmd vimrc CursorMoved * MilfeulleOverlay

" submode
call submode#enter_with('milfeulle', 'n', 'r', '<Space><C-o>', '<Plug>(milfeulle-prev)')
call submode#enter_with('milfeulle', 'n', 'r', '<Space><C-i>', '<Plug>(milfeulle-next)')
call submode#map('milfeulle', 'n', 'r', '<C-o>', '<Plug>(milfeulle-prev)')
call submode#map('milfeulle', 'n', 'r', '<C-i>', '<Plug>(milfeulle-next)')

" cheatsheet-echo
let s:tips = [
      \   '<Space><C-o>	前のカーソル位置へ',
      \   '<Space><C-i>	後のカーソル位置へ',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'milfeulle')
" }}}
