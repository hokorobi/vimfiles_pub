" hook_add {{{
BulkMap nxi <silent> <Home>   <Cmd>call smarthome#home()<CR>
BulkMap nxi <silent> <C-a>    <Cmd>call smarthome#home()<CR>
BulkMap nx <silent>  <Space>h <Cmd>call smarthome#home()<CR>
BulkMap nx <silent>  0        <Cmd>call smarthome#home()<CR>

BulkMap nxi <silent> <End>    <Cmd>call smarthome#end()<CR>
BulkMap nxi <silent> <C-e>    <Cmd>call smarthome#end()<CR>
BulkMap nx <silent>  <Space>l <Cmd>call smarthome#end()<CR>
BulkMap nx <silent>  $        <Cmd>call smarthome#end()<CR>
" }}}
