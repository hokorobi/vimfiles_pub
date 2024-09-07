" hook_add {{{
" Overwrite / and ?.
BulkMap nx ? <Cmd>call searchx#start(#{ dir: 0 })<CR>
BulkMap nx / <Cmd>call searchx#start(#{ dir: 1 })<CR>
nnoremap <Space>/ /

" Move to next/prev match.
BulkMap nx N <Cmd>call searchx#prev()<CR>
BulkMap nx n <Cmd>call searchx#next()<CR>
xnoremap <C-k> <Cmd>call searchx#prev()<CR>
xnoremap <C-j> <Cmd>call searchx#next()<CR>
cnoremap <expr> <C-k> getcmdtype() ==# ':' ? repeat('<Del>', strchars(getcmdline()[getcmdpos() - 1:])) : '<Cmd>call searchx#prev()<CR>'
cnoremap <C-j> <Cmd>call searchx#next()<CR>

" Customize behaviors.
let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" Marker Characters
let g:searchx.markers = split('JFKLUIONMHYDVCRETGB', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  return a:input !~# '\k' ? ('\V' .. a:input) : (join(split(a:input, ' '), '.\{-}'))
endfunction

" auto nohlsearch after cursor is moved.
" vim-hitspop の表示も消してもらえるので is.vim も削除した
let g:searchx.nohlsearch = {}
let g:searchx.nohlsearch.jump = v:true
" }}}
