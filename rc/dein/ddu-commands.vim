" hook_add {{{
call extend(g:vimrc_altercmd_dic, {
  \ 'ddu': 'Ddu',
  \})
" nnoremap <silent> <Space>du <Cmd>Ddu mr<CR>
nnoremap <silent> <Space>db <Cmd>Ddu buffer<CR>
nnoremap <silent> <Space>df <Cmd>Ddu file_rec<CR>
" nnoremap <silent> *         <Cmd>Ddu -name=search line -resume=v:false -input=`expand('<cword>')` -ui-param-startFilter=v:false<CR>
" }}}
