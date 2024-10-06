" hook_add {{{
let g:textobj#sentence#select = 'S'
call extend(g:vimrc_altercmd_dic, {
      \ 'sen\%[tence]': 'call textobj#sentence#init()',
      \ })
nmap <Space>e "zyiS;Textra en ja z<CR>
" }}}
