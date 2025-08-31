" hook_add {{{
nnoremap <expr> <M-t> printf('<Cmd>%s<CR>', floaterm#buflist#first() == -1 ? 'FloatermNew' : 'FloatermToggle')

" 履歴の差分から検索
nnoremap <Space>gg :FloatermNew git log -p -G
" }}}
" hook_source {{{
" exit してもウィンドウが残ると閉じないといけないので
let g:floaterm_autoclose = 1

autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <M-t> <Cmd>FloatermToggle<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-t> <Cmd>FloatermNew<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-k> <Cmd>FloatermPrev<CR>
autocmd vimrc User FloatermOpen tnoremap <buffer> <silent> <C-j> <Cmd>FloatermNext<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> <C-h> <Cmd>FloatermPrev<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> <C-k> <Cmd>FloatermPrev<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> <C-j> <Cmd>FloatermNext<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> <C-l> <Cmd>FloatermNext<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> qq <Cmd>FloatermToggle<CR>
autocmd vimrc User FloatermOpen nnoremap <buffer> <silent> ? <Cmd>call cheatsheetecho#CheatSheetEcho(v:true)<CR>

autocmd vimrc QuitPre * FloatermKill!

"cheatsheet-echo
let s:tips = [
      \   '<C-t>	FloatermNew',
      \   '<C-k>	FloatermPrev',
      \   '<C-j>	FloatermNext',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'floaterm')
" }}}
