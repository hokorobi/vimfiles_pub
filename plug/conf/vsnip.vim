" hook_source {{{
imap <silent><expr> <Tab>
      \ pumvisible() ? '<Down>' :
      \ vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' :
      \ '<Tab>'
smap <silent><expr> <Tab>  vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <silent><expr> <S-Tab>
      \ pumvisible() ? '<Up>' :
      \ vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' :
      \ '<C-h>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
imap <silent><expr> <C-j>
      \ pumvisible() ? '<C-n>' :
      \ '<C-j>'
imap <silent> <C-n> <Down>
imap <silent><expr> <C-k>
      \ pumvisible() ? '<C-p>' :
      \ '<Cmd>normal! D<CR>'
imap <silent> <C-p> <Up>

let g:vsnip_snippet_dir = expand('~/vimfiles/plug/vsnip')
" }}}
