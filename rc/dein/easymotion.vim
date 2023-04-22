" hook_add {{{
"map g/ <Plug>(easymotion-sn)

" bd: bidirection
" ?l: current line
BulkMap nxo <Space>/ <Plug>(easymotion-overwin-f2)
BulkMap nxo f <Plug>(easymotion-bd-fl)
BulkMap nxo F <Plug>(easymotion-Fl)
BulkMap nxo t <Plug>(easymotion-bd-tl)
BulkMap nxo T <Plug>(easymotion-Tl)

let g:EasyMotion_move_highlight = 0

highlight link EasyMotionTarget DiffDelete
" }}}
" hook_source {{{
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'hlasdgyuiopqwertnmzxcvbfkj;'
let g:EasyMotion_smartcase = 1
" PCを新しくしたらマシな速さになったみたい
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_do_shade = 0

" submode
call submode#enter_with('emn', 'nx', 'r', ':', '<Plug>(easymotion-next)')
call submode#enter_with('emn', 'nx', 'r', '<Space>;', '<Plug>(easymotion-next)')
call submode#enter_with('emn', 'nx', 'r', ',', '<Plug>(easymotion-prev)')
call submode#map('emn', 'nx', 'rs', ';', '<Plug>(easymotion-next)')
call submode#map('emn', 'nx', 'rs', ':', '<Plug>(easymotion-next)')
call submode#map('emn', 'nx', 'rs', ',', '<Plug>(easymotion-prev)')
" }}}
