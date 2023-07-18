scriptencoding utf-8

function plugin#ctrlpGeneric#paste(selected_value) abort
  let backregz = getreg('z')
  call setreg('z', ctrlp#filter#filtermethods(a:line))
  noautocmd normal! "zp
  call setreg('z', backregz)
endfunction

function plugin#ctrlpGeneric#cd(selected_value) abort
  execute $'cd {a:selected_value}'
endfunction

" 使用例：ghq からリポジトリを選択して CtrlP
function plugin#ctrlpGeneric#ctrlp(selected_value) abort
  execute $'CtrlP {a:selected_value}'
endfunction

" git log からコミットを選択してハッシュを Yank
" function plugin#ctrlpGeneric#yank(selected_value) abort
"   let hash = matchstr(a:selected_value, '\w\+')
"   call setreg('"', hash)
" endfunction
" nnoremap <Space>fg <Cmd>call CtrlPGeneric(systemlist('git log --date=short --pretty=format:"%h %cd %s"'), 'plugin#ctrlpGeneric#yank')<CR>

" git log からコミットを選択して、そのコミット時点のファイルを選択して開く
function plugin#ctrlpGeneric#ginEdit() abort
  call CtrlPGeneric(systemlist('git log --date=short --pretty=format:"%h %cd %s"'), 'plugin#ctrlpGeneric#getGitHash')
endfunction
function plugin#ctrlpGeneric#getGitHash(selected_value) abort
  const s:hash = matchstr(a:selected_value, '\w\+')
  call CtrlPGeneric(systemlist($'git ls-tree -r --name-only {s:hash}'), 'plugin#ctrlpGeneric#ginEditHash')
endfunction
function plugin#ctrlpGeneric#ginEditHash(selected_value) abort
  call execute($':GinEdit ++opener=vsplit {s:hash} {a:selected_value}')
endfunction

function plugin#ctrlpGeneric#pasteRstFigure(selected_value) abort
  call substitute('\\', '/', 'g')
  \  ->printf('.. figure:: %s')
  \  ->plugin#ctrlpGeneric#paste()
endfunction
