" hook_add {{{
xnoremap <Space>j <Plug>(edgemotion-j)
xnoremap <Space>k <Plug>(edgemotion-k)
nnoremap <expr> <Space>j &diff ? ']c' : '<Plug>(edgemotion-j)'
nnoremap <expr> <Space>k &diff ? '[c' : '<Plug>(edgemotion-k)'
" }}}
