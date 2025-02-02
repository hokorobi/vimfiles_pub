scriptencoding utf-8

" / と :s///g をトグル
" 8.1.0271 あたりから :s でハイライトされるようになったけどまだ使ってる
" https://github.com/cohama/.vim/commit/dc23152a2246435a9912bf37fe206638f47bda9f
function vimrc#ToggleSubstituteSearch(type, line) abort
  if a:type ==# '/' || a:type ==# '?'
    let range = s:GetOnetime('s:range', '%')
    return "\<End>\<C-u>\<BS>" .. substitute(a:line, '^\(.*\)', $':{range}s/\1', '')
  elseif a:type ==# ':'
    let g:line = a:line
    let [s:range, expr] = matchlist(a:line, '^\(.*\)s\%[ubstitute]\/\(.*\)$')[1:2]
    if s:range ==# '''<,''>'
      call setpos('.', getpos('''<'))
    endif
    return printf('<End><C-u><BS>/%s', expr)
  endif
endfunction
function s:GetOnetime(varname, defaultValue) abort
  if !exists(a:varname)
    return a:defaultValue
  endif

  let varValue = eval(a:varname)
  execute $'unlet {a:varname}'
  return varValue
endfunction


" My retab
" https://github.com/cohama/.vim/blob/85dd7d1f63eb3913cf9d13482c1772caa340fd7b/.vimrc#L1369-L1377
function vimrc#Retab(old_tabstop) abort
  let pos = getpos('.')
  let new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  silent execute printf('%%s/\v%(^ *)@<= {%s}/%s/ge', a:old_tabstop, new_indent)
  silent retab
  call setpos('.', pos)
endfunction

" インデントを簡単に設定
" ISetting    => 現在の状態を表示
" ISetting t4 => tab で幅4
" ISetting s2 => space で幅2
" https://github.com/cohama/.vim/blob/9bcf4c6da9ef538b75ba6052d592290e31d629bb/init.vim#L873-L905
function vimrc#ISettingCompl(A, L, P) abort
  return ['s2', 't4']
endfunction
function vimrc#ISetting(setting = '') abort
  if empty(a:setting)
    echo printf('indent: %s %s', ((&l:expandtab) ? 'space' : 'tab'), &l:shiftwidth)
    return
  endif

  if match(a:setting, '[1-9][st]') == 0
    let shiftwidth = a:setting[0]
    let expandflag = a:setting[1]
  elseif match(a:setting, '[st][1-9]') == 0
    let shiftwidth = a:setting[1]
    let expandflag = a:setting[0]
  else
    echo 'Arg Error'
    return
  endif
  if expandflag ==# 's'
    setlocal expandtab
  else
    setlocal noexpandtab
  endif

  let bk_tabstop = &l:tabstop

  let &l:shiftwidth  = shiftwidth
  let &l:softtabstop = shiftwidth
  let &l:tabstop     = shiftwidth

  call vimrc#Retab(bk_tabstop)
endfunction

" 開いているファイルのディレクトリへ移動
function vimrc#ChangeCurrentDir(directory, bang) abort
  if a:directory ==# ''
    lcd %:p:h
  else
    execute $'lcd {a:directory}'
  endif

  if a:bang ==# ''
    pwd
  endif
endfunction

" diff xdoc2txt
" vimdiff でファイルを開いた後に xdoc2txt でフィルタリングした結果を diffupdate
function vimrc#DiffXdoc2txt() abort
  if expand('%:e') !~? 'html\?'
    return
  endif

  nnoremap qq :<C-u>qa!<CR>

  windo %!xdoc2txt "%"
  windo setlocal wrap
  set diffopt+=iwhiteall
  diffupdate
endfunction

" toggle option
function vimrc#toggle_option(option_name) abort
  execute $'setlocal {a:option_name}! {a:option_name}?'
endfunction

function vimrc#format() abort
  let formatters = #{
        \  css: [
        \    ['deno', 'fmt --ext css -'],
        \  ],
        \  html: [
        \    ['deno', 'fmt --ext html -'],
        \  ],
        \  json: [
        \    ['deno', 'fmt --ext json -'],
        \    ['jj', '-p'],
        \    ['jq', '.'],
        \    ['python', '-m json.tool'],
        \  ],
        \  sql: [
        \    ['deno', 'fmt --unstable-sql -'],
        \  ],
        \  markdown: [
        \    ['deno', 'fmt --ext markdown -'],
        \  ],
        \  toml: [
        \    ['taplo', 'fmt -'],
        \  ],
        \  typescript: [
        \    ['deno', 'fmt --ext ts -'],
        \  ],
        \  yaml: [
        \    ['deno', 'fmt --ext yaml -'],
        \  ],
        \}

  if !has_key(formatters, &ft)
    echo 'No formatter'
    return
  endif
  for formatter in formatters[&ft]
    if Vimrc_executable(formatter[0])
      execute $'%!{formatter[0]} {formatter[1]}'
      return
    endif
  endfor
endfunction

" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
function vimrc#GrepWrap(path = '.') abort
  let str = input('Pattern: ')
  if len(str) == 0
    return 1
  endif
  let path = stridx(&grepprg, 'findstr') == 0 ? $'{a:path}/*' : a:path
  execute $'grep "{str}" {path}'
endfunction

" pt で grep を実行した後に結果をパス順にしたかったので sort
function vimrc#SortQuickfix(fn) abort
  call setqflist(sort(getqflist(), a:fn), 'r')
endfunction
function vimrc#QfStrCmp(e1, e2) abort
  let [t1, t2] = [bufname(a:e1.bufnr), bufname(a:e2.bufnr)]
  return t1 <? t2 ? -1 : t1 ==? t2 ? 0 : 1
endfunction

" split and go
function vimrc#SplitAndGo(cmd) abort
  execute a:cmd
  if v:count
    execute $'normal! {v:count}G'
  endif
endfunction

function vimrc#toggle_quickfix_window() abort
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    botright cwindow
  endif
endfunction

function vimrc#terminal_open(args) abort
  if empty(term_list())
    execute 'terminal' a:args
  else
    execute 'buffer' term_list()[0]
  endif
endfunction

" 端末ウィンドウを複製する
" https://vim-jp.org/slacklog/CJMV3MSLR/2021/05/#ts-1621213606.468200
function vimrc#term_view() abort
  let n = input('Term Num: ', '0')
  new
  put=getbufline(term_list()[n],1,'$')
endfunction

" 現在行を yank (行頭空白、行末空白・改行を除く)
" function vimrc#linecopy() abort
"   let view = winsaveview()
"   normal! 0vg_"+y
"   silent call winrestview(view)
" endfunction

" コマンドの結果をスクラッチバッファに表示
" function vimrc#L(args)
"   new
"   setlocal buftype=nofile bufhidden=delete noswapfile
"   nnoremap <buffer> qq <Cmd>close<CR>
"   call setline(1, split(execute(a:args), '\n'))
" endfunction

" https://github.com/Shougo/shougo-s-github/blob/bd8eeac18d8eb99c2db7f1edef443ff49016551e/vim/rc/deinft.vim#L136-L154
function! s:align_right(linenr) abort
  let m = a:linenr->getline()->matchlist('^\(\S\+\%(\s\S\+\)\?\)\?\s\+\(\*.\+\*\)')
  if m->empty()
    return
  endif
  call setline(a:linenr, $'{m[1]} '->repeat(&l:textwidth - len(m[1]) - len(m[2])) .. m[2])
endfunction
function! s:align_rights(start, end) abort
  for linenr in range(a:start, a:end)
    call s:align_right(linenr)
  endfor
endfunction

function! s:set_highlight(group) abort
  for group in ['helpBar', 'helpBacktick', 'helpStar', 'helpIgnore']
    execute 'highlight link' group a:group
  endfor
endfunction

" ycino@vim-jp slack
function vimrc#helpedittoggle() abort
  if &conceallevel == 0
    edit!
    return
  endif

  setlocal buftype= modifiable noreadonly
  setlocal list tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78
  setlocal colorcolumn=+1
  setlocal conceallevel=0

  call s:set_highlight('Special')

  " ヘルプ関連タグの右揃え
  command! -range -buffer AlignRight call s:align_rights('<line1>'->expand(), '<line2>'->expand())
  nnoremap <silent><buffer> mm <Cmd>AlignRight<CR>
  xnoremap <silent><buffer> mm :AlignRight<CR>
endfunction

" rbtnn@vim-jp slack
" https://vim-jp.slack.com/archives/CLKR04BEF/p1642317296122600
" '', "" を行き来する
function vimrc#percent_expr() abort
  let curr_char = getline('.')[col('.') - 1]
  if curr_char == '"'
    if col('.') == col('''>')
      return "v2i\"o\<esc>"
    else
      return "v2i\"\<esc>"
    endif
  elseif curr_char == "'"
    if col('.') == col('''>')
      return "v2i'o\<esc>"
    else
      return "v2i'\<esc>"
    endif
  else
    return '%'
  endif
endfunction

" 現在の選択範囲を取得 {{{
" https://zenn.dev/kawarimidoll/articles/4357f07f210d2f
function vimrc#get_current_selection() abort
  if mode() !~# '^[vV\x16]'
    " not in visual mode
    return ''
  endif

  " save current z register
  let save_reg = getreginfo('z')

  " get selection through z register
  noautocmd normal! "zygv
  let result = @z

  " restore z register
  call setreg('z', save_reg)

  return result
endfunction
" }}}

" Vimで空行挿入+dot repeat {{{
" https://zenn.dev/vim_jp/articles/8de697fc88e63c
function vimrc#blank_above(type = '') abort
  if a:type == ''
    set operatorfunc=function('vimrc#blank_above')
    return 'g@ '
  endif

  for i in range(v:count1)
    call append(line('.')-1, '')
  endfor
endfunction

function vimrc#blank_below(type = '') abort
  if a:type == ''
    set operatorfunc=function('vimrc#blank_below')
    return 'g@ '
  endif

  for i in range(v:count1)
    call append(line('.'), '')
  endfor
endfunction
"}}}

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

" 直前に入力した単語を大文字へ
" https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
function vimrc#toupper_prev_word()
  let col = getpos('.')[2]
  let substring = getline('.')[0:col-1]
  let word = matchstr(substring, '\v<(\k(<)@!)*$')
  return toupper(word)
endfunction

function vimrc#openbrowser(url) abort
  call job_start(['rundll32.exe', 'url.dll,FileProtocolHandler', a:url])
endfunction

function vimrc#openBrowserGitrepo() abort
  let repo = vimrc#getRepositoryName()
  if repo ==# '' || stridx(repo, '/') == -1
    echo 'リポジトリ名は取得できませんでした。'
    return
  endif

  call vimrc#openbrowser($'https://github.com/{repo}')
endfunction

function vimrc#openBrowserOpenUrlInBuffer() abort
  if &filetype != 'capture' && confirm("Open URLs in buffer?", "&Yes\n&No\n&Cancel") != 1
    return
  endif

  for line in getline(0, line("$"))
    let head = matchstr(line, 'https:\/\/github.com.\+\.\.\..\+')
    if len(head) >= 1
      call vimrc#openbrowser(head)
    endif
  endfor
endfunction

" plugin {{{1
" text-objects の i' か i" か iW か選択範囲を user/repogitory のリポジトリ名と想定して取得
function vimrc#getRepositoryName() abort
  const backregz = getreginfo('z')
  call setreg('z', '')
  if mode() !~# '^[vV\x16]'
    " not in visual mode

    for c in ['"', "'", 'W']
      execute $'noautocmd normal! "zyi{c}'
      if getreg('z') !=# ''
        break
      endif
    endfor
  else
    noautocmd normal! "zygv
  endif
  const repo = getreg('z')
  call setreg('z', backregz)
  if match(repo, '[^/]\+/[^/]\+$') == 0
    return repo
  else
    return ''
  endif
endfunction
" }}}1

