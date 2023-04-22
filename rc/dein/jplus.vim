" hook_add {{{
" 空白、行継続を削除して行を結合
BulkMap nx J <Plug>(jplus)

" 空白を削除した上で任意の文字を挿入して行を結合
BulkMap nx <Space>J <Plug>(jplus-input)
" }}}
