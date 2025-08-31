" hook_source {{{
imap <silent><expr> <C-l>
      \ pumvisible() ?
      \   vsnip#expandable() ? '<Plug>(vsnip-expand)' :
      \   '' :
      \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
      \ ''
" }}}
