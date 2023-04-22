" hook_source {{{
let g:equal_operator_default_mappings = 0

onoremap i=h <Plug>(operator-lhs)
onoremap a=h <Plug>(operator-Lhs)
xnoremap i=h <Plug>(visual-lhs)
xnoremap a=h <Plug>(visual-Lhs)

onoremap i=l <Plug>(operator-rhs)
onoremap a=l <Plug>(operator-Rhs)
xnoremap i=l <Plug>(visual-rhs)
xnoremap a=l <Plug>(visual-Rhs)
" }}}
