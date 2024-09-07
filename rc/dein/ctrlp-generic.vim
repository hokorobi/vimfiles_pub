" hook_add {{{
" 任意のコマンドの結果から選択して挿入
command! -nargs=* CtrlPCmdPaste call CtrlPGeneric(systemlist(<q-args>), 'plugin#ctrlpGeneric#paste')
nnoremap <Space>fc <Cmd>call systemlist('ghq list -p')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#cd')<CR>
" ghq からリポジトリのディレクトリを選択して、その中のファイルを選択
nnoremap <Space>fr <Cmd>call systemlist('ghq list -p')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#ctrlp')<CR>
" git log からコミットを選択して、そのコミット時点のカレントバッファのファイルを開く
nnoremap <Space>gbo <Cmd>call plugin#ctrlpGeneric#ginEditSelectHash()<CR>
nnoremap <Space>fn <Cmd>call glob('**/*')
      \ ->split('\n')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#paste')<CR>
" }}}
" rst {{{
" _build と autobuild の除外が動いていない。
" nnoremap <buffer> <Space>fn <Cmd>call CtrlPGeneric(glob("**/*")->split("\n")->filter('v:val !~ "^_build\|autobuild"'), 'plugin#ctrlpGeneric#pasteRstFigure')<CR>
nnoremap <buffer> <Space>fn <Cmd>call glob('**/*')
      \ ->split('\n')
      \ ->filter('v:val !~ "^_build"')
      \ ->filter('v:val !~ "^autobuild"')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#pasteRstFigure')<CR>
" }}}

