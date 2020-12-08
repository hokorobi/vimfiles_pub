scriptencoding utf-8

call lexima#set_default_rules()

" mode '/' {{{1
call lexima#add_rule({
      \   'char' : '/',
      \   'input': '\/',
      \   'mode' : '/',
      \})
" }}}1 mode '?' {{{1
call lexima#add_rule({
      \   'char' : '?',
      \   'input': '\?',
      \   'mode' : '?',
      \})
" }}}1 mode ':' {{{1
" :s/ -> :%s//g {{{2
call lexima#add_rule({
      \   'at'   : '^s\%#',
      \   'char' : '/',
      \   'input': '<Left><Left>%<Right><Right>/',
      \   'input_after': '/g',
      \   'mode' : ':',
      \})
call lexima#add_rule({
      \   'at'   : "^'<,'>s\\%#",
      \   'char' : '/',
      \   'input': '/',
      \   'input_after': '/g',
      \   'mode' : ':',
      \})

call lexima#add_rule({
      \   'at'   : '^s\%#',
      \   'char' : '@',
      \   'input': '<Left><Left>%<Right><Right>@',
      \   'input_after': '@g',
      \   'mode' : ':',
      \})
call lexima#add_rule({
      \   'at'   : "^'<,'>s\\%#",
      \   'char' : '@',
      \   'input': '@',
      \   'input_after': '@g',
      \   'mode' : ':',
      \})
" }}}2
" }}}1 mode 'i' {{{1
" docstring の改行 {{{2
for c in ["'", '"']
  call lexima#add_rule({
        \   'at'         : c .. '\{3}.*\%#' .. c .. '\{3}',
        \   'char'       : '<CR>',
        \   'input_after': '<CR>',
        \})
endfor

" }}}2 括弧補完を cgn で使う {{{2
" http://qiita.com/yami_beta/items/26995a5c382bd83ac38f
inoremap <silent> <C-f> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" }}}2 空白を後方に入力 {{{2
" https://github.com/awaman/dotfiles/blob/master/.vim/rc/lexima.vim
for c in [',']
  " 後にスペースを入れる
  " 末尾 \S だと行末尾でスペースが入らない様子
  call lexima#add_rule({
        \   'at'   : '\%#\_S',
        \   'char' : c,
        \   'input': c .. '<Space>',
        \})
  " 後にスペースを続けられないようにする
  call lexima#add_rule({
        \   'at'   : c .. ' \%#',
        \   'char' : '<Space>',
        \   'input': '',
        \})
  " 一度に削除する
  call lexima#add_rule({
        \   'at'   : '\S\+' .. c .. ' \%#',
        \   'char' : '<BS>',
        \   'input': '<BS><BS>',
        \})
  " [Volt] '(filetype|excmd)= の後ろなら空白なし
  call lexima#add_rule({
        \   'at'   : '''\(filetype\|excmd\)=.*\%#',
        \   'char' : c,
        \   'filetype' : 'vim'
        \})
endfor

" 末尾に空白があれば改行でなく削除
call lexima#add_rule({
      \   'at' : '\S\s\+\%#$',
      \   'char' : '<CR>',
      \   'input' : '<BS>',
      \})

" }}}2 = {{{2

" =の前後にスペースを入れる
call lexima#add_rule({
      \   'at'   : '[^<>	 ]\%#',
      \   'char' : '=',
      \   'input': '<Space>=<Space>',
      \})

call lexima#add_rule({
      \   'at'   : '[<>	 ]\%#',
      \   'char' : '=',
      \   'input': '=<Space>',
      \})

" =入力前にスペースがあったら入力しない
call lexima#add_rule({
      \   'at'   : '[^=]\+ [-+\\*/%=]\=\%#',
      \   'char' : '=',
      \   'input': '=<Space>',
      \})

" ' = 'の後ろにスペースをいれ続けない
call lexima#add_rule({
      \   'at'   : '\S\+\s[-+\\*/%=]\==\+\s\%#',
      \   'char' : '<Space>',
      \   'input': '',
      \})

" == の場合は1つスペースを消す
call lexima#add_rule({
      \   'at'   : '\S\+\s=\s\%#',
      \   'char' : '=',
      \   'input': '<BS>=<Space>',
      \})

" 演算子直後の=
call lexima#add_rule({
      \   'at'   : '\S\+[\!\-+\\*/%=]\%#',
      \   'char' : '=',
      \   'input': '<Left><Space><Right>=<Space>',
      \})

" ' = 'を一度に消す
call lexima#add_rule({
      \   'at'   : '\s=\s\%#',
      \   'char' : '<BS>',
      \   'input': '<BS><BS><BS>',
      \})

" ' == ', ' += '等を一度に消す
call lexima#add_rule({
      \   'at'   : '\s[\!\-+\\*/%=:]=\s\%#',
      \   'char' : '<BS>',
      \   'input': '<BS><BS><BS><BS>',
      \})

" }}}2 filetype {{{2
" vim {{{3

" set 系コマンドでは = の間にスペースを入れない
call lexima#add_rule({
      \   'at'      : '\%(^\||\|\\\)\s*set.*\%#',
      \   'char'    : '=',
      \   'filetype': 'vim',
      \})

" == の場合は ==# にする
call lexima#add_rule({
      \   'at'      : '\w\+ == \%#',
      \   'char'    : '=',
      \   'input'   : '<BS>#<Space>',
      \   'filetype': 'vim',
      \})

" ==# の場合は != にする
call lexima#add_rule({
      \   'at'      : '\w\+ ==# \%#',
      \   'char'    : '=',
      \   'input'   : '<BS><BS><BS><BS>!=<Space>',
      \   'filetype': 'vim',
      \})

" https://github.com/cohama/lexima.vim/issues/33
" "{{{|%#}}}
" ↓
" "{{{
" "}}}
call lexima#add_rule({
      \   'at'         : '{{{\%#}}}',
      \   'char'       : '<CR>',
      \   'input_after': '',
      \   'priority'   : 1,
      \   'filetype'   : 'vim',
      \})

" Vim scriptで以下のようなインデントをする {{{4
" NeoBundleLazy 'cohama/lexima.vim', {
" \   'autoload': {
" \       'insert': 1
" \   }
" \}

if &l:shiftwidth == 0
  let s:indent = &l:tabstop
else
  let s:indent = &l:shiftwidth
endif

" 改行時に \ 入力
for s:val in ['{:}', '\[:\]']
  let s:pair = split(s:val, ':')

  " {\%#}
  " ↓
  " {
  " \   \%#
  " \}
  call lexima#add_rule({
        \   'at'         : s:pair[0] .. '\%#' .. s:pair[1],
        \   'char'       : '<CR>',
        \   'input'      : '<CR><Bslash>   ',
        \   'input_after': '<CR><Bslash>',
        \   'filetype'   : 'vim',
        \})

  " indent 5つ分まで設定
  for s:i in range(1, 5)
    let s:space_num = s:indent * s:i - 1
    let s:space = ''
    for s:j in range(s:space_num + s:indent)
      let s:space = s:space .. ' '
    endfor
    let s:space_after = ''
    for s:j in range(s:space_num)
      let s:space_after = s:space_after .. ' '
    endfor

    " \   {\%#}
    " ^^^^ shiftwidthの倍数 - 1の長さ
    " ↓
    " \   {
    " \       \%#
    " \   }
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' .. s:space_num .. '\}.*' .. s:pair[0] .. '\%#' .. s:pair[1],
          \   'char'       : '<CR>',
          \   'input'      : '<CR><Bslash>' .. s:space,
          \   'input_after': '<CR><Bslash>' .. s:space_after,
          \   'filetype'   : 'vim',
          \})

    " \   hoge, \%#
    " ^^^^ shiftwidthの倍数 - 1の長さ
    " ↓
    " \   hoge,
    " \   \%#
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' .. s:space_num .. '\}.*\%#',
          \   'char'       : '<CR>',
          \   'input'      : '<CR><Bslash>' .. s:space_after,
          \   'filetype'   : 'vim',
          \})
    " 末尾スペース削除
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' .. s:space_num .. '\}.*\s\+\%#',
          \   'char'       : '<CR>',
          \   'input'      : '<Esc>diwo<Bslash>' .. s:space_after,
          \   'filetype'   : 'vim',
          \})
  endfor
endfor
" }}}4

" }}}3 go {{{3
" == の場合は := にする
call lexima#add_rule({
      \   'at'      : '\w\+ == \%#',
      \   'char'    : '=',
      \   'input'   : '<BS><BS><BS>:=<Space>',
      \   'filetype': ['go', 'autohotkey'],
      \})

" := の場合は != にする
call lexima#add_rule({
      \   'at'      : '\w\+ := \%#',
      \   'char'    : '=',
      \   'input'   : '<BS><BS><BS>!=<Space>',
      \   'filetype': 'go',
      \})

" != の場合は = にする
call lexima#add_rule({
      \   'at'      : '\w\+ != \%#',
      \   'char'    : '=',
      \   'input'   : '<BS><BS><BS>=<Space>',
      \   'filetype': 'go',
      \})

" != の場合は := にする
call lexima#add_rule({
      \   'at'      : '\w\+ != \%#',
      \   'char'    : '+',
      \   'input'   : '<BS><BS><BS>:=<Space>',
      \   'filetype': 'go',
      \})

" := の場合は == にする
call lexima#add_rule({
      \   'at'      : '\w\+ := \%#',
      \   'char'    : '+',
      \   'input'   : '<BS><BS><BS>==<Space>',
      \   'filetype': 'go',
      \})

" == の場合は = にする
call lexima#add_rule({
      \   'at'      : '\w\+ == \%#',
      \   'char'    : '+',
      \   'input'   : '<BS><BS><BS>=<Space>',
      \   'filetype': 'go',
      \})

" = の場合は != にする
call lexima#add_rule({
      \   'at'      : '\w\+ = \%#',
      \   'char'    : '+',
      \   'input'   : '<BS><BS>!=<Space>',
      \   'filetype': 'go',
      \})

" }}}3 python {{{3

" http://qiita.com/hatchinee/items/c5bc19a656925ce33882
" classとかの定義時に:までを入れる
call lexima#add_rule({
      \   'at'          : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#',
      \   'char'        : '(',
      \   'input'       : '(',
      \   'input_after' : '):',
      \   'filetype'    : ['python'],
      \   })

" すでに:がある場合は重複させない. (smartinputでは、atの定義が長いほど適用の優先度が高くなる)
call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#.*:',
      \   'char'    : '(',
      \   'input'   : '(',
      \   'input_after' : ')',
      \   'filetype': ['python'],
      \   })

" 末尾:の手前でも、エンターとか:で次の行にカーソルを移動させる
call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:$',
      \   'char'    : ':',
      \   'input'   : '<Right><CR>',
      \   'filetype': ['python'],
      \   })

call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:$',
      \   'char'    : '<CR>',
      \   'input'   : '<Right><CR>',
      \   'filetype': ['python'],
      \   })

" (): を一度に消す
call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+(\%#):$',
      \   'char'    : '<BS>',
      \   'input'   : '<BS>',
      \   'delete'  : 2,
      \   'filetype': ['python'],
      \   })

" デフォルト引数の場合は=の前後にスペースを入力しない
call lexima#add_rule({
      \   'at'      : '\w\+(\n\=\([^)]\+\n\)*[^)]\+\%#',
      \   'char'    : '=',
      \   'filetype': ['python'],
      \})

" ' = 'の後に改行したら'\'を入力
call lexima#add_rule({
      \   'at'      : ' = \%#',
      \   'char'    : '<CR>',
      \   'input'   : '\<CR>',
      \   'filetype': ['python'],
      \})

" クオート内改行では'\'を入力しない
call lexima#add_rule({
      \   'at'      : "'.* = \%#'",
      \   'char'    : '<CR>',
      \   'filetype': ['python'],
      \})

" クオート内改行では'\'を入力しない
call lexima#add_rule({
      \   'at'      : '".* = \%#"',
      \   'char'    : '<CR>',
      \   'filetype': ['python'],
      \})

" }}}3 markdown {{{3
" 改行後に末尾のスペースが2つ以上の場合は2つ残す
call lexima#add_rule({
      \   'at'      : '\S\+\s\s\+\%#$',
      \   'char'    : '<CR>',
      \   'input'   : '<ESC>ciw<Space><Space><CR>',
      \   'filetype': ['markdown'],
      \})

" コード PRE の改行
call lexima#add_rule({
      \   'at'         : '```.*\%#```',
      \   'char'       : '<CR>',
      \   'input_after': '<CR>',
      \   'filetype'   : ['markdown'],
      \})

" コード PRE shell の場合 プロンプト $ を自動入力
call lexima#add_rule({
      \   'at'      : '```sh\n\(\n.*\)*\%#\(\n.*\)*```',
      \   'char'    : '<CR>',
      \   'input'   : '<CR>$<Space>',
      \   'filetype': ['markdown'],
      \})

" コード PRE shell の場合 行頭スペースでプロンプト $ を自動入力
call lexima#add_rule({
      \   'at'      : '```sh\(\n.*\)*\n\%#\(\n.*\)*```',
      \   'char'    : '<Space>',
      \   'input'   : '$<Space>',
      \   'filetype': ['markdown'],
      \})

" コード PRE shell の場合 プロンプト $ を一括削除
call lexima#add_rule({
      \   'at'      : '```sh\(\n.*\)*$ \%#\(\n.*\)*```',
      \   'char'    : '<BS>',
      \   'input'   : '<BS><BS>',
      \   'filetype': ['markdown'],
      \})

" }}}3 others {{{3
call lexima#add_rule({
      \   'at'          : '``\%#',
      \   'char'        : '`',
      \   'input'       : '',
      \   'input_after' : '``',
      \   'filetype'    : ['rst']
      \})

" =の前後にスペースを入れない
call lexima#add_rule({
      \   'at'   : '.\%#',
      \   'char' : '=',
      \   'filetype': ['rst', 'sh']
      \})

" }}}3
" }}}2
" }}}1
