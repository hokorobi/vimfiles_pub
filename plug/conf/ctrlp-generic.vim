" hook_add {{{
" git log からコミットを選択して、そのコミット時点のカレントバッファのファイルを開く
nnoremap <Space>gbo <Cmd>call systemlist('git log --date=short --pretty=format:"%h %cd %s"')
  \  ->CtrlPGeneric('CtrlPGenericPassGitHash2GinEdit')<CR>

" ブランチを選択して switch
nnoremap <Space>gbb <Cmd>call systemlist('git branch')
  \  ->CtrlPGeneric('CtrlPGenericGitSwitch')<CR>

" カレントディレクトリ配下のファイル名を貼り付け
nnoremap <Space>fn <Cmd>call glob('**/*')
      \ ->split('\n')
      \ ->CtrlPGeneric('CtrlPGenericPaste')<CR>

" 任意のコマンドの結果から選択して挿入
command! -nargs=* CtrlPCmdPaste call systemlist(<q-args>)->CtrlPGeneric('CtrlPGenericPaste')

" cheatsheet-echo
let s:tips = [
      \   '<Space>gbo	git log からコミット、ファイルを選択して表示',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'ctrlp-generic', 'Git')
let s:tips = [
      \   '<Space>fn	カレントディレクトリ配下のファイル名を選択して貼り付け',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'ctrlp-generic')
" }}}
" hook_source {{{
function! CtrlPGenericCd(selected_value) abort
  execute $'cd {a:selected_value}'
endfunction

" 使用例：リポジトリディレクトリを選択して CtrlP
function! CtrlPGenericCtrlp(selected_value) abort
  execute $'CtrlP {a:selected_value}'
endfunction

function! CtrlPGenericDppUpdate(selected_value) abort
  call dpp#async_ext_action('installer', 'update', #{names: a:selected_value})
endfunction

" git log からコミットを選択して、そのコミット時点のファイルを選択して開く
function! CtrlPGenericPassGitHash2GinEdit(selected_value) abort
  const s:hash = matchstr(a:selected_value, '\w\+')
  call systemlist($'git ls-tree -r --name-only {s:hash}')
  \  ->CtrlPGeneric('CtrlPGenericGinEditHash')
endfunction
function! CtrlPGenericGinEditHash(selected_value) abort
  execute $':GinEdit ++opener=vsplit {s:hash} {a:selected_value}'
endfunction

" git log からコミットを選択して、そのコミットを show
function! CtrlPGenericGitShow() abort
  call systemlist('git log --date=short --pretty=format:"%h %cd %s"')
  \  ->CtrlPGeneric('CtrlPGenericGinBufferShow')
endfunction
function! CtrlPGenericGinBufferShow(hashDateSubject) abort
  call matchstr(a:hashDateSubject, '\w\+')
  \  ->printf(':GinBuffer show %s')
  \  ->execute()
endfunction

" ブランチを選択して switch
function! CtrlPGenericGitSwitch(selected_value) abort
  call substitute(a:selected_value, '\s*\*\?\s*\|\s\+', '', 'g')
  \  ->printf('!git switch %s')
  \  ->execute()
endfunction

function! CtrlPGenericPaste(selected_value) abort
  let backregz = getreg('z')
  call setreg('z', a:selected_value)
  noautocmd normal! "zp
  call setreg('z', backregz)
endfunction

function! CtrlPGenericPasteRstFigure(selected_value) abort
  call substitute(a:selected_value, '\\', '/', 'g')
  \  ->printf('.. figure:: %s')
  \  ->CtrlPGenericPaste()
endfunction

" git log からコミットを選択してハッシュを Yank
" function CtrlPGenericYank(selected_value) abort
"   let hash = matchstr(a:selected_value, '\w\+')
"   call setreg('"', hash)
" endfunction
" nnoremap <Space>fg <Cmd>call CtrlPGeneric(systemlist('git log --date=short --pretty=format:"%h %cd %s"'), 'CtrlPGenericYank')<CR>

" }}}
" rst {{{
" FIXME _build と autobuild の除外が動いていない。
" nnoremap <buffer> <Space>fn <Cmd>call CtrlPGeneric(glob("**/*")->split("\n")->filter('v:val !~ "^_build\|autobuild"'), 'CtrlPGenericPasteRstFigure')<CR>
nnoremap <buffer> <Space>fn <Cmd>call glob('**/*.png')
      \ ->split('\n')
      \ ->filter('v:val !~ "^_build"')
      \ ->filter('v:val !~ "^autobuild"')
      \ ->CtrlPGeneric('CtrlPGenericPasteRstFigure')<CR>

let s:tips = [
      \   '<Space>fn pngファイルを選択して .. figure: で貼り付け',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'rst', 'ctrlp-generic')
" }}}

