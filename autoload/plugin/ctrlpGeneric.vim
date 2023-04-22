scriptencoding utf-8

function! plugin#ctrlpGeneric#paste(selected_value) abort
  let backregz = getreg('z')
  call setreg('z', ctrlp#filter#filtermethods(a:line))
  noautocmd normal! "zp
  call setreg('z', backregz)
endfunction

function! plugin#ctrlpGeneric#cd(selected_value) abort
  execute printf('cd %s', a:selected_value)
endfunction

" ghq からリポジトリを選択して、その中のファイルを選択
function! plugin#ctrlpGeneric#ctrlp(selected_value) abort
  execute printf('CtrlP %s', a:selected_value)
endfunction

" git log からコミットを選択してハッシュを Yank
" function! plugin#ctrlpGeneric#yank(selected_value) abort
"   let hash = matchstr(a:selected_value, '\w\+')
"   call setreg('"', hash)
" endfunction
" nnoremap <Space>fg <Cmd>call CtrlPGeneric(systemlist('git log --date=short --pretty=format:"%h %cd %s"'), 'plugin#ctrlpGeneric#yank')<CR>

" git log からコミットを選択して、そのコミット時点のカレントバッファのファイルを開く
function! plugin#ctrlpGeneric#ginEdit(selected_value) abort
  " call feedkeys(printf(";GinEdit ++opener=vsplit %s %%", matchstr(a:selected_value, '\w\+')))
  call matchstr(a:selected_value, '\w\+')
  \  ->printf(":GinEdit ++opener=vsplit %s %%")
  \  ->execute()
endfunction

function! plugin#ctrlpGeneric#pasteRstFigure(selected_value) abort
  call substitute('\\', '/', 'g')
  \  ->printf('.. figure:: %s')
  \  ->plugin#ctrlpGeneric#paste()
endfunction
