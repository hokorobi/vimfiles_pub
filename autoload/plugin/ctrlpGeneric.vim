scriptencoding utf-8

function plugin#ctrlpGeneric#cd(selected_value) abort
  execute $'cd {a:selected_value}'
endfunction

" 使用例：リポジトリディレクトリを選択して CtrlP
function plugin#ctrlpGeneric#ctrlp(selected_value) abort
  execute $'CtrlP {a:selected_value}'
endfunction

function plugin#ctrlpGeneric#dppUpdate(selected_value) abort
  call dpp#async_ext_action('installer', 'update', #{names: a:selected_value})
endfunction

" git log からコミットを選択して、そのコミット時点のファイルを選択して開く
function plugin#ctrlpGeneric#passGitHash2GinEdit(selected_value) abort
  const s:hash = matchstr(a:selected_value, '\w\+')
  call systemlist($'git ls-tree -r --name-only {s:hash}')
  \  ->CtrlPGeneric('plugin#ctrlpGeneric#ginEditHash')
endfunction
function plugin#ctrlpGeneric#ginEditHash(selected_value) abort
  execute $':GinEdit ++opener=vsplit {s:hash} {a:selected_value}'
endfunction

" git log からコミットを選択して、そのコミットを show
function plugin#ctrlpGeneric#gitShow() abort
  call systemlist('git log --date=short --pretty=format:"%h %cd %s"')
  \  ->CtrlPGeneric('plugin#ctrlpGeneric#ginBufferShow')
endfunction
function plugin#ctrlpGeneric#ginBufferShow(hashDateSubject) abort
  call matchstr(a:hashDateSubject, '\w\+')
  \  ->printf(':GinBuffer show %s')
  \  ->execute()
endfunction

function plugin#ctrlpGeneric#paste(selected_value) abort
  let backregz = getreg('z')
  call setreg('z', a:selected_value)
  noautocmd normal! "zp
  call setreg('z', backregz)
endfunction

function plugin#ctrlpGeneric#pasteRstFigure(selected_value) abort
  call substitute(a:selected_value, '\\', '/', 'g')
  \  ->printf('.. figure:: %s')
  \  ->plugin#ctrlpGeneric#paste()
endfunction

" git log からコミットを選択してハッシュを Yank
" function plugin#ctrlpGeneric#yank(selected_value) abort
"   let hash = matchstr(a:selected_value, '\w\+')
"   call setreg('"', hash)
" endfunction
" nnoremap <Space>fg <Cmd>call CtrlPGeneric(systemlist('git log --date=short --pretty=format:"%h %cd %s"'), 'plugin#ctrlpGeneric#yank')<CR>

