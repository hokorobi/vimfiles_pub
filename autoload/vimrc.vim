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

  let l:line3 = s:genLine([&fileformat, l:fenc, l:ftype, l:pos[1] .. ':' .. l:pos[2]], ' | ')

  " カーソル位置のハイライト名を表示
  " https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
  let l:highlight =
        \ synstack(line('.'), col('.'))
        \ ->map({_, id -> synIDattr(id, 'name') == synIDtrans(id)->synIDattr('name')
        \       ? synIDattr(id, 'name')
        \       : printf('%s(%s)', synIDattr(id, 'name'), synIDtrans(id)->synIDattr('name'))})
        \ ->join(' -> ')

  let l:vsep = '--------------------------------'

  " format output
  let l:lines = ['hl: ' .. l:highlight, l:vsep, l:line2, l:vsep, l:line3]
  " open temporary popup
  call popup_atcursor(l:lines, #{
        \ border: [1, 1, 1, 1],
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
    execute printf('tabnew %s', fnameescape(a:file))
    return
  endif
  execute printf('e %s', fnameescape(a:file))
endfunction


" / と :s///g をトグル
" 8.1.0271 あたりから :s でハイライトされるようになったけどまだ使ってる
" https://github.com/cohama/.vim/commit/dc23152a2246435a9912bf37fe206638f47bda9f
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
    return printf('<End><C-U><BS>/%s', expr)
  endif
endfunction
function! s:GetOnetime(varname, defaultValue) abort
  if !exists(a:varname)
    return a:defaultValue
  endif

  let varValue = eval(a:varname)
  execute printf('unlet %s', a:varname)
  return varValue
endfunction


" My retab
" https://github.com/cohama/.vim/blob/85dd7d1f63eb3913cf9d13482c1772caa340fd7b/.vimrc#L1369-L1377
function! vimrc#Retab(old_tabstop) abort
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
function! vimrc#ISetting(setting) abort
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
function! vimrc#ChangeCurrentDir(directory, bang) abort
  if a:directory ==# ''
    lcd %:p:h
  else
    execute printf('lcd %s', a:directory)
  endif

  if a:bang ==# ''
    pwd
  endif
endfunction

" diff xdoc2txt
" vimdiff でファイルを開いた後に xdoc2txt でフィルタリングした結果を diffupdate
function! vimrc#DiffXdoc2txt() abort
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
function! vimrc#toggle_option(option_name) abort
  execute printf('setlocal %s! %s?', a:option_name, a:option_name)
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
    execute printf('%!%s %s', l:cmd, l:arg0)
    return
  endif
  if l:cmd ==# 'python'
    echom 'jj, jq コマンドが見つからないため式は評価できません。'
    return
  endif
  execute printf('%!%s "%s"', l:cmd, a:1)
endfunction


" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
function! vimrc#GrepWrap(...) abort
  let path = a:0 == 0 ? '.' : a:1
  let str = input('Pattern: ')
  if len(str) == 0
    return 1
  endif
  execute printf('grep "%s" %s', str, path)
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
  if v:count
    execute printf('normal! %sG', v:count)
  endif
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
" function! vimrc#linecopy() abort
"   let view = winsaveview()
"   normal! 0vg_"+y
"   silent call winrestview(view)
" endfunction

" コマンドの結果をスクラッチバッファに表示
" function! vimrc#L(args)
"   new
"   setlocal buftype=nofile bufhidden=delete noswapfile
"   nnoremap <buffer> qq <Cmd>close<CR>
"   call setline(1, split(execute(a:args), '\n'))
" endfunction

" ycino@vim-jp slack
function! vimrc#option_to_edit() abort
  setlocal buftype= modifiable noreadonly
  setlocal list tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78
  setlocal colorcolumn=+1
  setlocal conceallevel=0
endfunction


function! vimrc#percent_expr() abort
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

" https://zenn.dev/kawarimidoll/articles/4357f07f210d2f
" 現在の選択範囲を取得 {{{
function! vimrc#get_current_selection() abort
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

" https://zenn.dev/vim_jp/articles/8de697fc88e63c
" Vimで空行挿入+dot repeat {{{
function! vimrc#blank_above(type = '') abort
  if a:type == ''
    set operatorfunc=function('vimrc#blank_above')
    return 'g@ '
  endif

  for i in range(v:count1)
    call append(line('.')-1, '')
  endfor
endfunction

function! vimrc#blank_below(type = '') abort
  if a:type == ''
    set operatorfunc=function('vimrc#blank_below')
    return 'g@ '
  endif

  for i in range(v:count1)
    call append(line('.'), '')
  endfor
endfunction
"}}}

" plugin {{{1
" '' か "" で括られた文字列か選択範囲を user/repogitory のリポジトリ名と想定して取得
function! vimrc#getRepositoryName(mode) abort
  let backregz = getreg('z')
  call setreg('z', '')
  if a:mode ==# 'n'
    noautocmd normal! "zyi'
    if getreg('z') ==# ''
      noautocmd normal! "zyi"
    endif
  else
    noautocmd normal! gv"zy
  endif
  let repo = getreg('z')
  call setreg('z', backregz)
  if match(repo, '[^/]\+/[^/]\+$') == 0
    return repo
  else
    return ''
  endif
endfunction
" }}}1

