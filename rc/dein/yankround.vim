" hook_add {{{
BulkMap nx <expr> P yankround#is_active() ? '<Plug>(myyr)' : '<Plug>(yankround-P)'
BulkMap nx <expr> p yankround#is_active() ? '<Plug>(myyr)' : '<Plug>(yankround-p)'
nnoremap <Space>fp <Cmd>CtrlPYankRound<CR>

let g:yankround_dir = expand('~/_vim/.yankround')
let g:yankround_use_region_hl = 1
" }}}
" hook_source {{{
" submode
call submode#enter_with('yr', 'n', 'r', '<Plug>(myyr)', '<Plug>(yankround-prev)')
call submode#map('yr', 'n', 'rs', 'p', '<Plug>(yankround-prev)')
call submode#map('yr', 'n', 'rs', 'n', '<Plug>(yankround-next)')
call submode#map('yr', 'n', 'rs', 'P', '<Plug>(yankround-next)')
" }}}
