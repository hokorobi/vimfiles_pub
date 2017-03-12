scriptencoding utf-8

" ウィンドウが複数開いていたら新しいタブで開く
" 外部からファイルを渡して呼び出すことはできないのか？
function! vimrc#YetAnotherEdit(file)
  if winnr('$') > 1
    execute 'tabnew ' . fnameescape(a:file)
    return
  endif
  execute 'e ' . fnameescape(a:file)
endfunction


" / と :s///g をトグル
function! vimrc#ToggleSubstituteSearch(type, line)
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
function! s:GetOnetime(varname, defaultValue)
  if !exists(a:varname)
    return a:defaultValue
  endif

  let varValue = eval(a:varname)
  execute 'unlet ' . a:varname
  return varValue
endfunction


" My retab
function! vimrc#Retab(old_tabstop)
  let pos = getpos('.')
  let new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  silent execute '%s/\v%(^ *)@<= {' . a:old_tabstop . '}/' . new_indent . '/ge'
  silent retab
  call setpos('.', pos)
endfunction

" インデントを簡単に設定
function! vimrc#ISetting(setting, force_retab)
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
function! vimrc#DeleteMe(force)
  if a:force || !&modified
    let filename = expand('%')
    bdelete!
    call delete(filename)
  else
    echomsg 'File modified'
  endif
endfunction


" 今開いているファイルをリネーム
function! vimrc#RenameMe(newFileName)
  let currentFileName = expand('%')
  execute 'saveas ' . a:newFileName
  call delete(currentFileName)
endfunction

" cd
function! vimrc#ChangeCurrentDir(directory, bang)
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
function! vimrc#DiffXdoc2txt()
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
function! vimrc#toggle_option(option_name)
  execute 'setlocal' a:option_name . '!' a:option_name . '?'
endfunction

" jq
function! vimrc#Jq(...)
  if 0 ==# a:0
    let l:arg = '.'
  else
    let l:arg = a:1
  endif
  execute '%! jq "' . l:arg . '"'
endfunction


" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
" pt 用
function! vimrc#GrepWrap(...)
  let path = a:0 >= 1 ? a:1 : '.'
  let str = input('Pattern: ')
  if len(str) == 0
    return 1
  endif
  execute 'grep "' . str . '" ' . path
endfunction

" pt で grep を実行した後に結果をパス順にしたかったので sort
function! vimrc#SortQuickfix(fn)
  call setqflist(sort(getqflist(), a:fn))
endfunction
function! vimrc#QfStrCmp(e1, e2)
  let [t1, t2] = [bufname(a:e1.bufnr), bufname(a:e2.bufnr)]
  return t1 <? t2 ? -1 : t1 ==? t2 ? 0 : 1
endfunction

" 行をクリップボードへコピー（末尾改行なし、カーソル移動なし）
function! vimrc#linecopy()
  let view = winsaveview()
  normal! 0vg_"+y
  silent call winrestview(view)
endfunction

" smart indent when entering insert mode with i on empty lines
function! vimrc#IndentWithI()
  if len(getline('.')) == 0
    return 'cc'
  else
    return 'i'
  endif
endfunction

" split and go
function! vimrc#SplitAndGo(cmd)
  execute a:cmd
  if !v:count
    return
  endif
  execute 'normal! ' . v:count . 'G'
endfunction

function! vimrc#toggle_quickfix_window()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    botright cwindow
  endif
endfunction

" fullscreen toggle
function! vimrc#ToggleFullScreen()
  if g:vimrc_fullscreen == 1
    simalt ~r
    let g:vimrc_fullscreen = 0
  else
    simalt ~x
    let g:vimrc_fullscreen = 1
  endif
endfunction


" kana/vim-gf-user
" http://d.hatena.ne.jp/thinca/20140324/1395590910
" Windows foo.c:23 などでも gf で foo.c を開けるようにする
function! vimrc#GfFile()
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

