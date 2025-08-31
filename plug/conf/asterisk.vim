" hook_add {{{
let g:asterisk#keeppos = 1

noremap * <Plug>(asterisk-gz*)
noremap g* <Plug>(asterisk-z*)
noremap z* <Plug>(asterisk-*)
noremap gz* <Plug>(asterisk-g*)

" replace
noremap # <Plug>(asterisk-gz*)cgn
noremap g# <Plug>(asterisk-z*)cgn
" }}}
