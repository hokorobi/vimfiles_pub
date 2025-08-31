" hook_add {{{
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0

" TODO: submode を抜けるときに <silent> を効かせたいけど方法はないのかな？

" original isearch
call submode#enter_with('isearch', 'n', '', '<Space>n', 'n')
call submode#enter_with('isearch', 'n', '', '<Space>N', 'N')
call submode#map('isearch', 'n', '', 'n', 'n')
call submode#map('isearch', 'n', '', 'N', 'N')

" tab move
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')

" 変更した位置
call submode#enter_with('move-change', 'n', '', 'g;', 'g;')
call submode#enter_with('move-change', 'n', '', 'g,', 'g,')
call submode#map('move-change', 'n', '', ';', 'g;')
call submode#map('move-change', 'n', '', ',', 'g,')
call submode#map('move-change', 'n', '', ':', 'g,')

" move to next/previous fold
call submode#enter_with('move-to-fold', 'n', '', 'zj', 'zj')
call submode#enter_with('move-to-fold', 'n', '', 'zk', 'zk')
call submode#map('move-to-fold', 'n', '', 'j', 'zj')
call submode#map('move-to-fold', 'n', '', 'k', 'zk')

" 時系列 undo/redo
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')

" Visual モード時のインクリメント、デクリメント
" http://vim-jp.org/blog/2015/06/30/visual-ctrl-a-ctrl-x.html
call submode#enter_with('vinc', 'x', '', '<Space>a', '<c-a>gv')
call submode#enter_with('vinc', 'x', '', '<Space>x', '<c-x>gv')
call submode#map('vinc', 'x', '', 'a', '<c-a>gv')
call submode#map('vinc', 'x', '', 'x', '<c-x>gv')
" }}}
