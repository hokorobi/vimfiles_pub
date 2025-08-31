" hook_source {{{
imap <silent><expr> <C-l>
      \ pumvisible() ?
      \   vsnip#expandable() ? '<Plug>(vsnip-expand)' :
      \   asyncomplete#close_popup() :
      \   '' :
      \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
      \ ''
" }}}
