" hook_add {{{
nnoremap <Space>gbl <Cmd>Gina blame<CR>
" }}}
" hook_source {{{
" show から戻るときは <C-o>
call gina#custom#mapping#nmap('blame', 's', ':<C-u>Gina show<CR>', #{noremap: 1, silent: 1, buffer: 1, nowait: 1})
call gina#custom#mapping#nmap('blame', 'e', '<Plug>(gina-blame-echo)', #{noremap: 0, buffer: 1, nowait: 1})
" }}}
