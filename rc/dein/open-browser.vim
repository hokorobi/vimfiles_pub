" hook_add {{{
BulkMap nx <Space>oo <Plug>(openbrowser-open)

nnoremap <Space>og <Cmd>call plugin#openBrowser#gitrepo('n')<CR>
xnoremap <Space>og <Cmd>call plugin#openBrowser#gitrepo('v')<CR>
nnoremap <Space>ob <Cmd>call plugin#openBrowser#openUrlInBuffer()<CR>
" }}}
