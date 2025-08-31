" hook_add {{{
" TODO: LSP を使わない filetype では有効にする
let g:qfloc_disable_sign = v:true
let g:qfloc_disable_default_mappings = v:true
let g:qfloc_disable_hover = v:true

nnoremap Q <Plug>(qfloc-cswitch)
nnoremap L <Plug>(qfloc-lswitch)
" nnoremap <expr> ]c &diff ? ']c' : '<Plug>(qfloc-cnext)'
" nnoremap <expr> [c &diff ? '[c' : '<Plug>(qfloc-cprevious)'
" nnoremap ]l <Plug>(qfloc-lnext)
" nnoremap [l <Plug>(qfloc-lprevious)
" }}}
" qf {{{
" nnoremap <buffer> j <Plug>(qfloc-j)
" nnoremap <buffer> k <Plug>(qfloc-k)
" nnoremap <buffer> s <Plug>(qfloc-sbuffer)
" nnoremap <buffer> p <Plug>(qfloc-preview)
nnoremap <buffer> u <Plug>(qfloc-undo)
nnoremap <buffer> dd <Plug>(qfloc-delete)
xnoremap <buffer> d  <Plug>(qfloc-delete)
" }}}
