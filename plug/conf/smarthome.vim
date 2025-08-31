" hook_add {{{
BulkMap nxi <silent> <Home>   <Cmd>call smarthome#Home()<CR>
BulkMap nxi <silent> <C-a>    <Cmd>call smarthome#Home()<CR>
BulkMap nx <silent>  <Space>h <Cmd>call smarthome#Home()<CR>
BulkMap nx <silent>  0        <Cmd>call smarthome#Home()<CR>

BulkMap nxi <silent> <End>    <Cmd>call smarthome#End()<CR>
BulkMap nxi <silent> <C-e>    <Cmd>call smarthome#End()<CR>
BulkMap nx <silent>  <Space>l <Cmd>call smarthome#End()<CR>
BulkMap nx <silent>  $        <Cmd>call smarthome#End()<CR>
" }}}
