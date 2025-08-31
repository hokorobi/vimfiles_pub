vim9script
scriptencoding utf-8

# move {{{1
# split and go
export def SplitAndGo(cmd: string)
  execute cmd
  if v:count > 0
    execute $'normal! {v:count}G'
  endif
enddef

# rbtnn@vim-jp slack
# https://vim-jp.slack.com/archives/CLKR04BEF/p1642317296122600
# '', "" を行き来する
# FIXME " が単体である場合にビジュアルモードに入ってしまう
export def PercentExpr(): string
  const curr_char = getline('.')[col('.') - 1]
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
enddef
# }}}1 file {{{1
#  今開いているファイルを削除
export def DeleteMe(force: bool)
  if force || !&modified
    expand('%')->delete()
    bdelete!
  else
    echomsg 'File modified'
  endif
enddef

# Cached executable
# https://github.com/DeaR/dotfiles/blob/7c021c276903d93e413bf0b4c7b134b1e0c8f946/.vimrc#L119-L126
#   g:vimrc_executable は vimrc で定義しておく
export def Vimrc_executable(cmd: string): number
  if !has_key(g:vimrc_executable, cmd)
    g:vimrc_executable[cmd] = executable(cmd)
  endif
  return g:vimrc_executable[cmd]
enddef

# xdoc2txt で変換したファイルを diff
# ppx.html の比較によく使っている。
export def DiffXdoc2txt()
  if expand('%:e') !~? 'html\?'
    return
  endif

  nnoremap qq :<C-u>qa!<CR>

  windo :%!xdoc2txt "%"
  windo setlocal wrap
  setglobal diffopt+=iwhiteall
  diffupdate
enddef

# }}}1 look {{{1
# Show cursor info / buffer info in popup
# https://github.com/kyoh86/dotfiles/blob/03ab2a71e691b4a9eee4f03f4693fd515e33afc9/vim/vimrc#L866-L896
export def Popup_cursor_info()
  const ro = &readonly ? 'RO' : ''
  const swap = get(b:, 'swapfile_exists', 0) ? 'swp' : ''
  const fname = &buftype ==# 'quickfix' ? get(w:, 'quickfix_title', '') : fnamemodify(bufname('%'), ':.')
  const modified = &modified ? '+' : ''
  const line2 = GenLine([modified, ro, swap, fname, getcwd()])

  const ftype = &filetype ==# '' ? '' : &filetype
  # get cursor position informations
  const pos = getpos('.')
  # get encoding
  var fenc = &fileencoding == '' ? &encoding : &fileencoding
  fenc = &bomb ? $'{fenc} (BOM)' : fenc
  const line3 = GenLine([&fileformat, fenc, ftype, $'{pos[1]}:{pos[2]}'])

  # get charcode informations
  # const charcode = getline('.')->strpart(col('.') - 1)->strcharpart(0, 1)->char2nr()->printf('charcode: %d')

  # カーソル位置のハイライト名
  # https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
  const highlight =
    synstack(line('.'), col('.'))
    ->map((_, id) => synIDattr(id, 'name') == synIDtrans(id)->synIDattr('name')
          ? synIDattr(id, 'name')
          : printf('%s(%s)', synIDattr(id, 'name'), synIDtrans(id)->synIDattr('name')))
    ->join(' -> ')

  const vsep = '--------------------------------'

  [highlight, vsep, line2, vsep, line3]
  ->popup_atcursor({
    border: [1, 1, 1, 1],
    pos: 'topleft',
    moved: 'any',
    padding: [0, 1, 0, 1],
    wrap: v:false,
    })
enddef
def GenLine(list: list<string>): string
  return filter(list, 'v:val !=# ""')->join(' | ')
enddef

# カーソル下のハイライトの情報表示
# https://zenn.dev/vim_jp/articles/show-hlgroup-under-cursor
export def ShowHighlightGroup()
  var hlgroup = synIDattr(synID(line('.'), col('.'), 1), 'name')
  var groupChain: list<string> = []

  while hlgroup !=# ''
    groupChain->add(hlgroup)
    hlgroup = execute($'highlight {hlgroup}')->trim()->matchstr('\<links\s\+to\>\s\+\zs\w\+$')
  endwhile

  if empty(groupChain)
    echo 'No highlight groups'
    return
  endif

  for group in groupChain
    execute 'highlight' group
  endfor
enddef

export def Echolist(list: list<string>)
  echo join(list, "\n")
enddef

# }}}1 edit {{{1
# My retab
# https://github.com/cohama/.vim/blob/85dd7d1f63eb3913cf9d13482c1772caa340fd7b/.vimrc#L1369-L1377
export def Retab(old_tabstop: number)
  const pos = getpos('.')
  const new_indent = &l:expandtab ? repeat(' ', &l:tabstop) : '\t'
  # silent! execute printf(':%%s/\v%(^ *)@<= {%s}/%s/ge', old_tabstop, new_indent)
  silent! execute $':%s/\v%(^ *)@<= {{{old_tabstop}}}/{new_indent}/ge'
  retab
  call setpos('.', pos)
enddef

# インデントを簡単に設定
# ISetting    => 現在の状態を表示
# ISetting t4 => tab で幅4
# ISetting s2 => space で幅2
# https://github.com/cohama/.vim/blob/9bcf4c6da9ef538b75ba6052d592290e31d629bb/init.vim#L873-L905
export def ISettingCompl(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
  return ['s2', 't4']
enddef
export def ISetting(setting: string = '')
  if empty(setting)
    echo printf('indent: %s %s', (&l:expandtab ? 'space' : 'tab'), &l:shiftwidth)
    return
  endif

  var expandflag: string
  var shiftwidth: number
  if match(setting, '[st][1-9]') == 0
    expandflag = setting[0]
    shiftwidth = str2nr(setting[1])
  else
    echo 'Arg Error'
    return
  endif

  if expandflag ==# 's'
    setlocal expandtab
  else
    setlocal noexpandtab
  endif

  const bk_tabstop = &l:tabstop

  &l:shiftwidth  = shiftwidth
  &l:softtabstop = shiftwidth
  &l:tabstop     = shiftwidth

  # Retab 関数が事前に定義されている必要があります
  Retab(bk_tabstop)
enddef

# Vimで空行挿入+dot repeat {{{
# https://zenn.dev/vim_jp/articles/8de697fc88e63c
export def BlankAbove(type: string = ''): string
  if type == ''
    set operatorfunc=funcref('BlankAbove')
    return 'g@ '
  endif

  for i in range(v:count1)
    append(line('.') - 1, '')
  endfor

  return ''
enddef

export def BlankBelow(type: string = ''): string
  if type == ''
    set operatorfunc=funcref('BlankBelow')
    return 'g@ '
  endif

  for i in range(v:count1)
    append(line('.'), '')
  endfor

  return ''
enddef
#}}}

# 直前に入力した単語を大文字へ
# https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
export def ToupperPrevWord(): string
  var col = getpos('.')[2]
  var substring = getline('.')[0 : col - 2]
  var word = matchstr(substring, '\v<(\k(<)@!)*$')
  return toupper(word)
enddef

export def Format()
  const formatters = {
    css: [
      ['deno', 'fmt --ext css -'],
    ],
    html: [
      ['deno', 'fmt --ext html -'],
    ],
    json: [
      ['deno', 'fmt --ext json -'],
      ['jj', '-p'],
      ['jq', '.'],
      ['python', '-m json.tool'],
    ],
    jsonc: [
      ['deno', 'fmt --ext json -'],
      ['jj', '-p'],
      ['jq', '.'],
      ['python', '-m json.tool'],
    ],
    sql: [
      ['deno', 'fmt --unstable-sql -'],
    ],
    markdown: [
      ['deno', 'fmt --ext markdown -'],
    ],
    toml: [
      ['taplo', 'fmt -'],
    ],
    typescript: [
      ['deno', 'fmt --ext ts -'],
    ],
    yaml: [
      ['deno', 'fmt --ext yaml -'],
    ],
  }
  if !has_key(formatters, &ft)
    echo 'No formatter'
    return
  endif
  for formatter in formatters[&ft]
    if Vimrc_executable(formatter[0])
      Format_execute($'{formatter[0]} {formatter[1]}')
      return
    endif
  endfor
enddef
# https://zenn.dev/vim_jp/articles/20250305_ekiden_vim_script_format
def Format_execute(cmd: string)
  const result = systemlist(cmd, getline(1, '$'))

  if v:shell_error != 0
    for l in result
      echoerr l
    endfor
    return
  endif

  const view = winsaveview()
  deletebufline(1, '$')
  setline(1, result)
  winrestview(view)
enddef
# }}}1 others {{{1

export def ToggleQuickfixWindow()
    const win_count = winnr('$')
    cclose
    if win_count == winnr('$')
        botright cwindow
    endif
enddef

# toggle option
export def ToggleOption(option_name: string)
  execute $'setlocal {option_name}! {option_name}?'
enddef

# 開いているファイルのディレクトリへ移動
export def ChangeCurrentDir(directory: string, bang: string)
  if directory ==# ''
    # 現在開いているファイルのディレクトリへ移動
    lcd %:p:h
  else
    # 指定されたディレクトリへ移動
    execute $'lcd {directory}'
  endif

  # bangが指定されていない場合は現在のディレクトリを表示
  if bang ==# ''
    pwd
  endif
enddef

# ファイラからの起動時に検索文字列を指定すると Vim の検索履歴を使えないので
# コマンド実行後に検索文字列を入力できるようにする
export def GrepWrap(path: string = '.')
  const str = input('Pattern: ')
  if len(str) == 0
    return
  endif

  # findstr を使うときはパス配下を検索できるように加工
  const search_path = stridx(&grepprg, 'findstr') == 0 ? $'{path}/*' : path

  execute $'grep "{str}" {search_path}'
enddef

# pt で grep を実行した後に結果をパス順にしたかったので sort
export def SortQuickfix()
  var newTitle = '[Sorted] ' .. getqflist({'title': 1}).title
  getqflist()->sort('QfStrCmp')->setqflist('r')
  setqflist([], 'r', {'title': newTitle})
enddef
def QfStrCmp(e1: dict<any>, e2: dict<any>): number
  var [t1, t2] = [bufname(e1.bufnr), bufname(e2.bufnr)]
  return t1 < t2 ? -1 : t1 == t2 ? 0 : 1
enddef

# text-objects の i' か i" か iW か選択範囲を user/repogitory のリポジトリ名と想定して取得
# Using CtrlP
export def GetRepositoryName(): string
  var repo = ''
  if mode() !~# '^[vV\x16]'
    # not in visual mode

    var backregz = getreginfo('z')
    setreg('z', [])
    for c in ['"', "'", 'W']
      execute $'noautocmd normal! "zyi{c}'
      if getreg('z') !=# ''
        break
      endif
    endfor
    repo = getreg('z')
    setreg('z', backregz)
  else
    repo = getregion(getpos('.'), getpos('v'))[0]
  endif
  if match(repo, '[^/]\+/[^/]\+$') == 0
    return repo
  else
    return ''
  endif
enddef

# 現在の選択範囲を取得
# https://zenn.dev/kawarimidoll/articles/4357f07f210d2f
# Using CtrlP
export def GetCurrentSelection(): string
  # not in visual mode
  if mode() !~# '^[vV\x16]'
    return ''
  endif

  return getregion(getpos('.'), getpos('v'))[0]
enddef

# }}}1 openbrowser {{{1
# Using dpp.vim
export def MyOpenBrowser(url: string)
  job_start(['rundll32.exe', 'url.dll,FileProtocolHandler', url])
enddef

export def OpenBrowserUrlInBuffer()
  if &filetype != 'capture' && confirm('Open URLs in buffer?', "&Yes\n&No\n&Cancel") != 1
    return
  endif

  for line in getline(1, line('$'))
    var head = matchstr(line, 'https:\/\/github\.com\/\S\+')
    if len(head) >= 1
      MyOpenBrowser(head)
    endif
  endfor
enddef

export def OpenBrowserGitrepo()
  var repo = GetRepositoryName()
  if repo ==# '' || stridx(repo, '/') == -1
    echo 'リポジトリ名は取得できませんでした。'
    return
  endif

  MyOpenBrowser($'https://github.com/{repo}')
enddef

# }}}1

# def で定義している関数を変更、追加した場合は一時的にコメントを外してエラーがないか確認する。
# defcompile
