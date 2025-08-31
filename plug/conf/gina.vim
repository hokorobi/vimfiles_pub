" hook_add {{{
nnoremap <Space>gbl <Cmd>Gina blame<CR>
" }}}
" hook_source {{{
" show から戻るときは <C-o>
call gina#custom#mapping#nmap('blame', 's', ':<C-u>Gina show<CR>', #{noremap: 1, silent: 1, buffer: 1, nowait: 1})
call gina#custom#mapping#nmap('blame', 'e', '<Plug>(gina-blame-echo)', #{noremap: 0, buffer: 1, nowait: 1})
" <C-L> のデフォルトマッピングは使わない
call gina#custom#mapping#nmap('blame', '<C-l>', '<C-w>l', #{noremap: 0, buffer: 1, nowait: 1})
" jumpoutで横方向に分割すると変なことになるのでこちらに変えておく。
call gina#custom#mapping#nmap('blame', '<C-h>', '<C-w>h', #{noremap: 0, buffer: 1, nowait: 1})

let g:sayonara_filetypes['gina-blame'] = 'tabclose'
" }}}
