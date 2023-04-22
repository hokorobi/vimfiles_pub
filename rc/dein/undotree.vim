" hook_add {{{
nnoremap [toggle]u <Cmd>UndotreeToggle<CR>
call extend(g:vimrc_altercmd_dic, {
      \   'undot\%[reetoggle]': 'UndotreeToggle',
      \ })
" }}}
" hook_source {{{
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
" }}}
