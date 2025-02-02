" hook_add {{{
" git log からコミットを選択して、そのコミット時点のカレントバッファのファイルを開く
nnoremap <Space>gbo <Cmd>call systemlist('git log --date=short --pretty=format:"%h %cd %s"')
  \  ->CtrlPGeneric('plugin#ctrlpGeneric#passGitHash2GinEdit')<CR>

" カレントディレクトリ配下のファイルを貼り付け
nnoremap <Space>fn <Cmd>call glob('**/*')
      \ ->split('\n')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#paste')<CR>

" 任意のコマンドの結果から選択して挿入
command! -nargs=* CtrlPCmdPaste call systemlist(<q-args>)->CtrlPGeneric('plugin#ctrlpGeneric#paste')
" }}}
" rst {{{
" _build と autobuild の除外が動いていない。
" nnoremap <buffer> <Space>fn <Cmd>call CtrlPGeneric(glob("**/*")->split("\n")->filter('v:val !~ "^_build\|autobuild"'), 'plugin#ctrlpGeneric#pasteRstFigure')<CR>
nnoremap <buffer> <Space>fn <Cmd>call glob('**/*.png')
      \ ->split('\n')
      \ ->filter('v:val !~ "^_build"')
      \ ->filter('v:val !~ "^autobuild"')
      \ ->CtrlPGeneric('plugin#ctrlpGeneric#pasteRstFigure')<CR>
" }}}

