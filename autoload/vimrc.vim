scriptencoding utf-8


" Show cursor info / buffer info in popup
" https://github.com/kyoh86/dotfiles/blob/03ab2a71e691b4a9eee4f03f4693fd515e33afc9/vim/vimrc#L866-L896
function! vimrc#popup_cursor_info()
  let l:ro = &readonly ? 'RO' : ''
  let l:swap = get(b:, 'swapfile_exists', 0) ? 'swp' : ''
  let l:fname = &buftype ==# 'quickfix' ? get(w:, 'quickfix_title', '') : fnamemodify(bufname('%'), ':.')
  let l:modified = &modified ? '+' : ''
  let l:line2 = s:genLine([l:modified, l:ro, l:swap, l:fname, getcwd()], ' | ')

  let l:ftype = &filetype ==# '' ? '' : &filetype
  " get cursor position informations
  let l:pos = getpos('.')
  " get charcode informations
  let l:char = strcharpart(strpart(getline('.'), col('.') - 1), 0, 1)
  let l:charnr = char2nr(l:char)
  " get encoding
  let l:fenc = &fileencoding == '' ? &encoding : &fileencoding
  let l:fenc = l:fenc !=# 'utf-8' ? fenc : &bomb ? fenc .. ' (BOM)' : fenc

  let l:line3 = s:genLine([&fileformat, l:fenc, l:ftype, 'Col: ' .. l:pos[2]], ' | ')

  " カーソル位置のハイライト名を表示
  " https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
  let l:highlight = join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name") .. "(" .. synIDattr(synIDtrans(v:val), "name") .. ")"'), ',')

  let l:vsep = '--------------------------------'

  " format output
  let l:lines = ['hl: ' .. l:highlight, l:vsep, l:line2, l:vsep, l:line3]
  " open temporary popup
  call popup_atcursor(l:lines, #{
        \ pos: 'topleft',
        \ moved: 'any',
        \ padding: [0, 1, 0, 1],
        \ wrap: v:false,
        \ })
endfunction
function! s:genLine(list, sep) abort
  let l:line = ''
  for l:s in a:list
    let l:line = l:s ==# '' ? l:line : l:line .. l:s .. a:sep
  endfor
  return l:line[0:-strlen(a:sep)]
endfunction

" ウィンドウが複数開いていたら新しいタブで開く
" 外部からファイルを渡して呼び出すことはできないのか？
function! vimrc#YetAnotherEdit(file) abort
  if winnr('$') > 1
    execute 'tabnew ' .. fnameescape(a:file)
    return
  endif
  execute 'e ' .. fnameescape(a:file)
endfunction


" / と :s///g をトグル
function! vimrc#ToggleSubstituteSearch(type, line) abort
  if a:type ==# '/' || a:type ==# '?'
    let range = s:GetOnetime('s:range', '%')
    return "\<End>\<C-U>\<BS>" .. substitute(a:line, '^\(.*\)', ':' .. range .. 's/\1', '')
  elseif a:type ==# ':'
    let g:line = a:line
    let [s:range, expr] = matchlist(a:line, '^\(.*\)s\%[ubstitute]\/\(.*\)$')[1:2]
    if s:range ==# '''<,''>'
      call setpos('.', getpos('''<'))
    endif
    return "\<End>\<C-U>\<BS>" .. '/' .. expr
  endif
endfunction
function! s:GetOnetime(varname, defaultValue) abort
  if !exists(a:varname)
    return a:defaultValue
  endif

  let varValue = eval(a:varname)
  execute 'unlet ' .. a:varname
  return varValue
endfunction


" My retab
function! vimrc#Retab(old_tabstop) abort
  let pos = getpos('.')
  let new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  silent execute '%s/\v%(^ *)@<= {' .. a:old_tabstop .. '}/' .. new_indent .. '/ge'
  silent retab
  call setpos('.', pos)
endfunction

" インデントを簡単に設定
function! vimrc#ISetting(setting, force_retab) abort
  if empty(a:setting)
    echo 'indent: ' .. ((&l:expandtab) ? 'space' : 'tab') .. ' ' .. &l:shiftwidth
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
    execute 'Retab ' .. bk_tabstop
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
  execute 'saveas ' .. a:newFileName
  call delete(currentFileName)
endfunction

" 開いているファイルのディレクトリへ移動
function! vimrc#ChangeCurrentDir(directory, bang) abort
  if a:directory ==# ''
    lcd %:p:h
  else
    execute 'lcd ' .. a:directory
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
  windo setlocal wrap
  set diffopt+=iwhiteall
  diffupdate
endfunction

" toggle option
function! vimrc#toggle_option(option_name) abort
  execute 'setlocal' a:option_name .. '!' a:option_name .. '?'
endfunction

" json processor
function! vimrc#Jq(...) abort
  if Vimrc_executable('jj')
    " http://qiita.com/tekkoc/items/324d736f68b0f27680b8
    let l:cmd = 'jj'
    let l:arg0 = '-p'
  elseif Vimrc_executable('jq')
    " https://github.com/stedolan/jq
    let l:cmd = 'jq'
    let l:arg0 = '.'
  else
    let l:cmd = 'python'
    let l:arg0 = '-m json.tool'
  endif

  if 0 ==# a:0
    execute '%!' .. l:cmd .. ' ' .. l:arg0
    return
  endif
  if l:cmd ==# 'python'
    echom 'jj, jq コマンドが見つからないため式は評価できません。'
    return
  endif
  execute '%!' .. l:cmd ' "' .. a:1 .. '"'
endfunction


" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
function! vimrc#GrepWrap(...) abort
  let path = a:0 == 0 ? '.' : a:1
  let str = input('Pattern: ')
  if len(str) == 0
    return 1
  endif
  execute 'grep "' .. str .. '" ' .. path
endfunction

" pt で grep を実行した後に結果をパス順にしたかったので sort
function! vimrc#SortQuickfix(fn) abort
  call setqflist(sort(getqflist(), a:fn), 'r')
endfunction
function! vimrc#QfStrCmp(e1, e2) abort
  let [t1, t2] = [bufname(a:e1.bufnr), bufname(a:e2.bufnr)]
  return t1 <? t2 ? -1 : t1 ==? t2 ? 0 : 1
endfunction

" split and go
function! vimrc#SplitAndGo(cmd) abort
  execute a:cmd
  if !v:count
    return
  endif
  execute 'normal! ' .. v:count .. 'G'
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
" https://vim-jp.org/slacklog/CJMV3MSLR/2021/05/#ts-1621213606.468200
function! vimrc#term_view() abort
  let n = input('Term Num: ', '0')
  new
  put=getbufline(term_list()[n],1,'$')
endfunction

" 現在行を yank (行頭空白、行末空白・改行を除く)
function! vimrc#linecopy() abort
  let view = winsaveview()
  normal! 0vg_"+y
  silent call winrestview(view)
endfunction

" コマンドの結果をスクラッチバッファに表示
function! vimrc#L(args)
  new
  setlocal buftype=nofile bufhidden=delete noswapfile
  nnoremap <buffer> qq <Cmd>close<CR>
  call setline(1, split(execute(a:args), '\n'))
endfunction

" Swap {{{
" https://github.com/thinca/config/blob/a8e3ee41236fcdbfcfa77c954014bc977bc6d1c6/dotfiles/dot.vim/vimrc#L651-L687
function! vimrc#on_SwapExists() abort
  if !filereadable(expand('<afile>'))
    let v:swapchoice = 'd'
    return
  endif
  let v:swapchoice = get(b:, 'swapfile_choice', 'o')
  unlet! b:swapfile_choice
  if v:swapchoice !=# 'd'
    let b:swapfile_exists = 1
  endif
endfunction

function! vimrc#swapfile_recovery() abort
  if get(b:, 'swapfile_exists', 0)
    let b:swapfile_choice = 'r'
    unlet b:swapfile_exists
    edit
  endif
endfunction

function! vimrc#swapfile_delete() abort
  if get(b:, 'swapfile_exists', 0)
    let b:swapfile_choice = 'd'
    unlet b:swapfile_exists
    edit
  endif
endfunction
" }}}


" plugin {{{1
" '' か "" で括られた文字列か選択範囲を user/repogitory のリポジトリ名と想定して取得
function! s:getRepogitoryName(mode) abort
  let backup_z = @z
  let @z = ''
  if a:mode ==# 'n'
    normal! "zyi'
    if @z ==# ''
      normal! "zyi"
    endif
  else
    normal! gv"zy
  endif
  let repo = @z
  let @z = backup_z
  return repo
endfunction

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
  let path = findfile(path, getcwd() .. ';')  " 追加
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
  let dir = a:dir .. strftime('/%Y/%m')
  if isdirectory(dir) == 0
    call mkdir(dir, 'p')
  endif
  let file = strftime('/%Y%m%d%H%M%S.howm')
  execute 'edit ' .. dir .. file
  Template howm
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

" }}}2 open-browser {{{2
function! vimrc#openGithubRepository(mode) abort
  let repo = s:getRepogitoryName(a:mode)
  if repo ==# '' || stridx(repo, '/') == -1
    echo 'リポジトリ名は取得できませんでした。'
    return
  endif

  call openbrowser#open('https://github.com/' .. repo)
endfunction

" }}}2 CtrlP {{{2

function! vimrc#CtrlPRepository(mode) abort
  execute 'CtrlP' '~/_vim/dein/repos/github.com/' .. s:getRepogitoryName(a:mode)
endfunction

" CtrlP のコマンドと初期入力値を指定して実行
function! vimrc#CtrlPDefaultInput(cmd, input)
  try
    let l:default_input_save = get(g:, 'ctrlp_default_input', '')
    let g:ctrlp_default_input = a:input
    execute a:cmd
  finally
    if exists('l:default_input_save')
      let g:ctrlp_default_input = l:default_input_save
    endif
  endtry
endfunction
" }}}2

" }}}1

