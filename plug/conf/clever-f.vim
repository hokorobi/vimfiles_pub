" hook_add {{{
let g:clever_f_not_overwrites_standard_mappings = 1
nnoremap f <Plug>(clever-f-f)
nnoremap F <Plug>(clever-f-F)
nnoremap t <Plug>(clever-f-t)
nnoremap T <Plug>(clever-f-T)
" }}}
" hook_source {{{
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1
let g:clever_f_across_no_line = 1

" submode
call submode#enter_with('emn', 'nx', 'r', '<Space>;', '<Plug>(clever-f-repeat-forward)')
call submode#enter_with('emn', 'nx', 'r', ',,', '<Plug>(clever-f-repeat-back)')
call submode#map('emn', 'nx', 'rs', ';', '<Plug>(clever-f-repeat-forward)')
call submode#map('emn', 'nx', 'rs', ':', '<Plug>(clever-f-repeat-back)')
call submode#map('emn', 'nx', 'rs', ',', '<Plug>(clever-f-repeat-back)')
" }}}
