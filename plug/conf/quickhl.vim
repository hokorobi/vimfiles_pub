" hook_add {{{
BulkMap nx <Space>m <Plug>(quickhl-manual-this)
BulkMap nx <Space>M <Plug>(quickhl-manual-reset)

"cheatsheet-echo
call cheatsheetecho#CheatSheetEchoAdd(['<Space>m / <Space>M	単語を目立たせる/リセット'], '_', 'quickhl')
" }}}
