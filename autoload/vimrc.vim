scriptencoding utf-8

" ウィンドウが複数開いていたら新しいタブで開く
" 外部からファイルを渡して呼び出すことはできないのか？
function! vimrc#YetAnotherEdit(file) abort
  if winnr('$') > 1
    execute 'tabnew ' . fnameescape(a:file)
    return
  endif
  execute 'e ' . fnameescape(a:file)
endfunction


" / と :s///g をトグル
" 8.1.0271 あたりからいらなくなったはず
function! vimrc#ToggleSubstituteSearch(type, line) abort
  if a:type ==# '/' || a:type ==# '?'
    let range = s:GetOnetime('s:range', '%')
    return "\<End>\<C-U>\<BS>" . substitute(a:line, '^\(.*\)', ':' . range . 's/\1', '')
  elseif a:type ==# ':'
    let g:line = a:line
    let [s:range, expr] = matchlist(a:line, '^\(.*\)s\%[ubstitute]\/\(.*\)$')[1:2]
    if s:range ==# '''<,''>'
      call setpos('.', getpos('''<'))
    endif
    return "\<End>\<C-U>\<BS>" . '/' . expr
  endif
endfunction
function! s:GetOnetime(varname, defaultValue) abort
  if !exists(a:varname)
    return a:defaultValue
  endif

  let varValue = eval(a:varname)
  execute 'unlet ' . a:varname
  return varValue
endfunction


" My retab
function! vimrc#Retab(old_tabstop) abort
  let pos = getpos('.')
  let new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  silent execute '%s/\v%(^ *)@<= {' . a:old_tabstop . '}/' . new_indent . '/ge'
  silent retab
  call setpos('.', pos)
endfunction

" インデントを簡単に設定
function! vimrc#ISetting(setting, force_retab) abort
  if empty(a:setting)
    echo 'indent: ' . ((&l:expandtab) ? 'space' : 'tab') . ' ' . &l:shiftwidth
    return
  endif

  if match(a:setting[0], '[st]') || str2nr(a:setting[1:]) == 0
    echo 'Arg Error'
    return
  endif

  if a:setting[0] ==# 's'
    setlocal expandtab
  else
    setlocal noexpandtab
  endif

  let shiftwidth = a:setting[1]
  let bk_tabstop = &l:tabstop

  let &l:shiftwidth  = shiftwidth
  let &l:softtabstop = shiftwidth
  let &l:tabstop     = shiftwidth

  " 強制的に Retab をかける
  if a:force_retab
    execute 'Retab ' . bk_tabstop
  endif

  " IndentGuides を再描画させるため
  doautocmd WinEnter
endfunction


" 今開いているファイルを削除
function! vimrc#DeleteMe(force) abort
  if a:force || !&modified
    let filename = expand('%')
    bdelete!
    call delete(filename)
  else
    echomsg 'File modified'
  endif
endfunction


" 今開いているファイルをリネーム
function! vimrc#RenameMe(newFileName) abort
  let currentFileName = expand('%')
  execute 'saveas ' . a:newFileName
  call delete(currentFileName)
endfunction

" 開いているファイルのディレクトリへ移動
function! vimrc#ChangeCurrentDir(directory, bang) abort
  if a:directory ==# ''
    lcd %:p:h
  else
    execute 'lcd ' . a:directory
  endif

  if a:bang ==# ''
    pwd
  endif
endfunction

" diff xdoc2txt
" vimdiff でファイルを開いた後に xdoc2txt でフィルタリングした結果を diffupdate
function! vimrc#DiffXdoc2txt() abort
  nnoremap qq :<C-u>qa!<CR>

  if expand('%:e') !~? 'html\?'
    return
  endif
  windo %!xdoc2txt "%"
  diffupdate
endfunction


" , 区切りの文字列をソートする（行全体）
function! vimrc#sortline(bang, ...) abort
  let space = a:bang ==# '!' ? '' : ' '
  let currentDelimiter = a:0 > 0 ? a:1 : ','
  let newDelimiter = a:0 > 1 ? a:2 : currentDelimiter

  let line = substitute(getline('.'), ' *' . currentDelimiter . ' *', ',', 'g')
  let newLine = join(sort(split(line, ',')), newDelimiter.space)
  call setline('.', newLine)
endfunction


" toggle option
function! vimrc#toggle_option(option_name) abort
  execute 'setlocal' a:option_name . '!' a:option_name . '?'
endfunction

" jq
function! vimrc#Jq(...) abort
  if 0 ==# a:0
    let l:arg = '.'
  else
    let l:arg = a:1
  endif
  execute '%! jq "' . l:arg . '"'
endfunction

" jj
function! vimrc#Jj(...) abort
  if 0 ==# a:0
    let l:arg = '-p'
  else
    let l:arg = a:1
  endif
  execute '%! jj "' . l:arg . '"'
endfunction


" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
" pt 用
function! vimrc#GrepWrap(...) abort
  let path = a:0 >= 1 ? a:1 : '.'
  let str = input('Pattern: ')
  if len(str) == 0
    return 1
  endif
  execute 'grep "' . str . '" ' . path
endfunction

" pt で grep を実行した後に結果をパス順にしたかったので sort
function! vimrc#SortQuickfix(fn) abort
  call setqflist(sort(getqflist(), a:fn))
endfunction
function! vimrc#QfStrCmp(e1, e2) abort
  let [t1, t2] = [bufname(a:e1.bufnr), bufname(a:e2.bufnr)]
  return t1 <? t2 ? -1 : t1 ==? t2 ? 0 : 1
endfunction

" smart indent when entering insert mode with i on empty lines
function! vimrc#IndentWithI() abort
  if len(getline('.')) == 0
    return 'cc'
  else
    return 'i'
  endif
endfunction

" split and go
function! vimrc#SplitAndGo(cmd) abort
  execute a:cmd
  if !v:count
    return
  endif
  execute 'normal! ' . v:count . 'G'
endfunction

function! vimrc#toggle_quickfix_window() abort
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    botright cwindow
  endif
endfunction

function! vimrc#terminal_open(args) abort
  if empty(term_list())
    execute 'terminal' a:args
  else
    execute 'buffer' term_list()[0]
  endif
endfunction

" 端末ウィンドウを複製する
function! vimrc#dup_term_buf() abort
  let file = tempname()
  call term_dumpwrite('', file)
  call term_dumpload(file)
  setlocal nolist
  call delete(file)
endfunction

let s:hint_i_ctrl_x_msg = join([
      \ 'l: While lines',
      \ 'n/p: keywords in the current file',
      \ "k: keywords in 'dictionary'",
      \ "t: keywords in 'thesaurus'",
      \ 'i: keywords in the current and included files',
      \ ']: tags',
      \ 'f: file names',
      \ 'd: definitions or macros',
      \ 'v: Vim command-line',
      \ "u: User defined completion ('completefunc')",
      \ "o: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! vimrc#InsCompl() abort
  echo s:hint_i_ctrl_x_msg
  let c = nr2char(getchar())
  if c == 'l'
    return "\<C-x>\<C-l>"
  elseif c == 'n'
    return "\<C-x>\<C-n>"
  elseif c == 'p'
    return "\<C-x>\<C-p>"
  elseif c == 'k'
    return "\<C-x>\<C-k>"
  elseif c == 't'
    return "\<C-x>\<C-t>"
  elseif c == 'i'
    return "\<C-x>\<C-i>"
  elseif c == ']'
    return "\<C-x>\<C-]>"
  elseif c == 'f'
    return "\<C-x>\<C-f>"
  elseif c == 'd'
    return "\<C-x>\<C-d>"
  elseif c == 'v'
    return "\<C-x>\<C-v>"
  elseif c == 'u'
    return "\<C-x>\<C-u>"
  elseif c == 'o'
    return "\<C-x>\<C-o>"
  elseif c == 's'
    return "\<C-x>s"
  elseif c == nr2char(27)
    " ESC
    return ''
  endif
  return "\<Tab>"
endfunction

" QuickFix か loclist かをを自動的に判定して項目移動 {{{
function! s:listmove(winnr, direction) abort
  let l:wi = getwininfo(win_getid(a:winnr))[0]
  if l:wi.loclist
    if a:direction ==# 'next'
      silent! lnext
    else
      silent! lprevious
    endif
    return v:true
  elseif l:wi.quickfix
    if a:direction ==# 'next'
      silent! cnext
    else
      silent! cprevious
    endif
    return v:true
  endif
  return v:false
endfunction

function! vimrc#listmove(direction) abort
  for i in range(1, winnr('$'))
    if s:listmove(i, a:direction)
      return
    endif
  endfor
endfunction
" }}}

" plugin {{{1

" gf-user {{{2
" http://d.hatena.ne.jp/thinca/20140324/1395590910
" Windows foo.c:23 などでも gf で foo.c を開けるようにする
function! vimrc#GfFile() abort
  let path = expand('<cfile>')
  let line = 0
  if path =~# ':\d\+:\?$'
    let line = matchstr(path, '\d\+:\?$')
    let path = matchstr(path, '.*\ze:\d\+:\?$')
  endif
  let path = findfile(path, getcwd() . ';')  " 追加
  if !filereadable(path)
    return 0
  endif
  return {
        \   'path': path,
        \   'line': line,
        \   'col':  0,
        \ }
endfunction

" }}}2 template {{{2
function! vimrc#EditHowmNew(dir) abort
  let dir = a:dir.strftime('/%Y/%m')
  if isdirectory(dir) == 0
    call mkdir(dir, 'p')
  endif
  let file = strftime('/%Y%m%d%H%M%S.howm')
  execute 'edit '.dir.file
  TemplateLoad
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

" }}}2 Denite {{{2

" 2017-03-30 現在の Denite では Windows で grep にディレクトリを渡すとエラーになる場合があるので cd する
" 最近の更新で grep:'C:\path\to\dir'::^=\\s が使えるようになったかと思ったが、カレントディレクトリが C ドライブでないとエラーになる
function! vimrc#DeniteGrepHowm() abort
  execute 'cd '.g:howm_dir
  Denite -resume -buffer-name=denite-howm -cursor-wrap grep:::^=\\s
endfunction

" }}}2

" }}}1

