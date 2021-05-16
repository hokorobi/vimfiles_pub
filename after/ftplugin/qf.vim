setlocal nobuflisted
nnoremap <buffer> <CR> <CR>

" pt で grep を実行した後に結果をパス順にしたかったので sort
" QuickFixCmdPost で実行していたけど w:quickfix_title が常に setqflist() になってしまうのでやめ。
" http://stackoverflow.com/questions/15393301/automatically-sort-quickfix-entries-by-line-text-in-vim
nnoremap <buffer> sq <Cmd>call vimrc#SortQuickfix('vimrc#QfStrCmp')<CR>

