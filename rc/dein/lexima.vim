" hook_source {{{
let g:lexima_ctrlh_as_backspace = 1
" <Esc> へのマッピングを活かすため '' へ
let g:lexima_map_escape = ''

source ~/vimfiles/rc/lexima.vim
" 継続行の改行時に \ を入力するため
autocmd vimrc FileType vim nmap <buffer> o A<CR>
" }}}
