" hook_add {{{
nnoremap <expr> <M-t> printf('<Cmd>%s<CR>', floaterm#buflist#first() == -1 ? 'FloatermNew' : 'FloatermToggle')
" }}}
" hook_source {{{
" exit してもウィンドウが残ると閉じないといけないので
let g:floaterm_autoclose = 1

autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <M-t> <Cmd>FloatermToggle<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-t> <Cmd>FloatermNew<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-k> <Cmd>FloatermPrev<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-j> <Cmd>FloatermNext<CR>

autocmd vimrc QuitPre * FloatermKill!
" }}}
