" hook_add {{{
let g:textobj_functioncall_no_default_key_mappings = 1

" func(arg)
" <-------> af
"      <-> if
" https://scrapbox.io/vim-jp/sandwich,_textobj%E3%81%A7Generics%E3%82%92%E6%89%B1%E3%81%86
xnoremap if <Plug>(textobj-functioncall-innerparen-i)
onoremap if <Plug>(textobj-functioncall-innerparen-i)
xnoremap af <Plug>(textobj-functioncall-i)
onoremap af <Plug>(textobj-functioncall-i)
" }}}
