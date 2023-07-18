" hook_add {{{
command! -nargs=* CtrlPCmdPaste call CtrlPGeneric(systemlist(<q-args>), 'plugin#ctrlpGeneric#paste')
nnoremap <Space>fc <Cmd>call CtrlPGeneric(systemlist('ghq list -p'), 'plugin#ctrlpGeneric#cd')<CR>
" ghq からリポジトリのディレクトリを選択して、その中のファイルを選択
nnoremap <Space>fr <Cmd>call CtrlPGeneric(systemlist('ghq list -p'), 'plugin#ctrlpGeneric#ctrlp')<CR>
" git log からコミットを選択して、そのコミット時点のカレントバッファのファイルを開く
nnoremap <Space>gbo <Cmd>call plugin#ctrlpGeneric#ginEdit()<CR>
" }}}
