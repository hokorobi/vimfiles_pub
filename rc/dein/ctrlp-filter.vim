" hook_add {{{
nnoremap <Space>fn <Cmd>call ctrlp#filter#do('CtrlP')<CR>
" }}}
" rst {{{
nnoremap <buffer> <Space>fn <Cmd>call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute', 'printf'], methodsargs: #{substitute: ['\\', '/', 'g'], printf: ['.. figure:: %s']}})<CR>
" }}}
