vim9script
scriptencoding utf-8

g:lexima_ctrlh_as_backspace = 1
# <Esc> へのマッピングを活かすため '' へ
g:lexima_map_escape = ''
# 継続行の改行時に \ を入力するため
autocmd vimrc FileType vim nmap <buffer> o A<CR>

# https://github.com/KentoOgata/dotfiles/blob/06f146495dbbe347f1d6439f7dd77516dc5c1e63/dot_config/nvim/plugins.d/lexima.vim#L2-L4
def Add_rules(shared: dict<any>, rules: list<dict<any>>)
  for rule in rules
    lexima#add_rule(extend(rule, shared))
  endfor
enddef

lexima#set_default_rules()

# mode '/' {{{1
lexima#add_rule({
  char: '/',
  input: '\/',
  mode: '/',
})

# }}}1 mode '?' {{{1
lexima#add_rule({
  char: '?',
  input: '\?',
  mode: '?',
})

# }}}1 mode ':' {{{1
for c in ['/', '@']
  Add_rules(
    {char: c, input_after: $'{c}g', mode: ':' },
    [
      # :s -> :%s//g
      {at: '^s\%#', input: $'<BS>%s{c}'},
      # :'<,'>s -> :'<,'>s//g
      {at: "^'<,'>s\\%#", input: c},
    ]
  )
endfor

# }}}1 mode 'i' {{{1
# docstring の改行 {{{2
for c in ["'", '"']
  lexima#add_rule({
    at: $'{c}\{{3}}.*\%#{c}\{{3}}',
    char: '<CR>',
    input_after: '<CR>',
  })
endfor

# }}}2 括弧補完を cgn で使う {{{2
# http://qiita.com/yami_beta/items/26995a5c382bd83ac38f
inoremap <silent> <C-f> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

# }}}2 空白を後方に入力 {{{2
# https://github.com/awaman/dotfiles/blob/master/.vim/rc/lexima.vim
for c in [',']
  # 後にスペースを入れる
  # 末尾 \S だと行末尾でスペースが入らない様子
  lexima#add_rule({
    at: '\%#\_S',
    char: c,
    input: $'{c}<Space>',
  })
  # 後にスペースを続けられないようにする
  lexima#add_rule({
    at: $'{c} \%#',
    char: '<Space>',
    input: '',
  })
  # 一度に削除する
  lexima#add_rule({
    at: $'\S\+{c} \%#',
    char: '<BS>',
    input: '<BS><BS>',
  })
endfor

# 末尾に空白があれば改行でなく削除
lexima#add_rule({
  at: '\S\s\+\%#$',
  char: '<CR>',
  input: '<BS>',
})

# }}}2 = {{{2

Add_rules(
  {char: '='},
  [
    # =の前後にスペースを入れる
    {at: '[^<>	 ]\%#', input: '<Space>=<Space>'},
    {at: '[<>	 ]\%#', input: '=<Space>'},
    # =入力前にスペースがあったら入力しない
    {at: '[^=]\+ [-+\\*/%=]\=\%#', input: '=<Space>'},
    # == の場合は1つスペースを消す
    {at: '\S\+\s=\s\%#', input: '<BS>=<Space>'},
    # 演算子直後の=
    {at: '\S\+[\!\-+\\*/%=]\%#', input: '<Left><Space><Right>=<Space>'},
  ]
)

# ' = 'の後ろにスペースをいれ続けない
lexima#add_rule({
  at: '\S\+\s[-+\\*/%=]\==\+\s\%#',
  char: '<Space>',
  input: '',
})

Add_rules(
  {char: '<BS>'},
  [
    # ' = 'を一度に消す
    {at: '\s=\s\%#', input: '<BS><BS><BS>'},
    # ' == ', ' += '等を一度に消す
    {at: '\s[\!\-+\\*/%=:]=\s\%#', input: '<BS><BS><BS><BS>'},
  ]
)

# }}}2 filetype {{{2
# vim {{{3
Add_rules(
  {filetype: 'vim', char: '='},
  [
    # set 系コマンドでは = の間にスペースを入れない
    {at: '\%(^\||\|\\\)\s*set.*\%#'},
    # command -nargs の後ろの = はスペースなし
    {at: '-nargs\%#'},
    # cyclic = -> == -> ==# -> !=
    {at: ' == \%#', input: '<BS>#<Space>'},
    {at: ' ==# \%#', input: '<BS><BS><BS><BS>!=<Space>'},
    {at: ' != \%#', input: '<BS><BS><BS>=<Space>'},
  ]
)

Add_rules(
  {filetype: 'vim', char: '<CR>', priority: 1, input_after: ''},
  [
    # https://github.com/cohama/lexima.vim/issues/33
    # " {{{|%#}}}
    # ↓
    # " {{{
    # " |}}}
    { at: '"[^{]*{{{\%#}}}', input: '<CR>" ', },
    # " {{{|%#
    # ↓
    # " {{{
    # |
    { at: '".*{\%#$', },
  ]
)

# 改行時に \ 入力 {{{4
const indent = &l:shiftwidth == 0 ? &l:tabstop : &l:shiftwidth
for val in ['{:}', '\[:\]']
  const pair = split(val, ':')

  # {\%#}
  # ↓
  # {
  # \   \%#
  # \}
  lexima#add_rule({
    at: $'{pair[0]}\%#{pair[1]}',
    char: '<CR>',
    input: '<CR><Bslash>   ',
    input_after: '<CR><Bslash>',
    filetype: 'vim',
  })

  # indent 5つ分まで設定
  for i in range(1, 5)
    const space_num = indent * i - 1
    var space = ''
    for j in range(space_num + indent)
      space ..= ' '
    endfor
    var space_after = ''
    for j in range(space_num)
      space_after ..= ' '
    endfor

    Add_rules(
      {filetype: 'vim', char: '<CR>'},
      [
        # \   {\%#}
        # ^^^^ shiftwidthの倍数 - 1の長さ
        # ↓
        # \   {
        # \       \%#
        # \   }
        {at: $'^\s*\\\s\{{{space_num}\}}.*{pair[0]}\%#{pair[1]}', input: $'<CR><Bslash>{space}', input_after: $'<CR><Bslash>{space_after}'},

        # \   hoge, \%#
        # ^^^^ shiftwidthの倍数 - 1の長さ
        # ↓
        # \   hoge,
        # \   \%#
        {at: $'^\s*\\\s\{{{space_num}\}}.*\%#', input: $'<CR><Bslash>{space_after}'},
        # 末尾スペース削除
        {at: $'^\s*\\\s\{{{space_num}\}}.*\s\+\%#', input: $'<Esc>diwo<Bslash>{space_after}'},
      ]
    )
  endfor
endfor
# }}}4

# }}}3 go {{{3
# cycle = -> == <-> := <-> !=. = で ->, + で <-
Add_rules(
  {filetype: 'go', char: '='},
  [
    {at: ' == \%#', input: '<BS><BS><BS>:=<Space>'},
    {at: ' := \%#', input: '<BS><BS><BS>!=<Space>'},
    {at: ' != \%#', input: '<BS><BS><BS>=<Space>'},
  ]
)
Add_rules(
  {filetype: 'go', char: '+'},
  [
    {at: ' != \%#', input: '<BS><BS><BS>:=<Space>'},
    {at: ' := \%#', input: '<BS><BS><BS>==<Space>'},
    {at: ' == \%#', input: '<BS><BS><Space>'},
    # = の場合は != にする
    {at: ' = \%#', input: '<BS><BS>!=<Space>'},
  ]
)

# }}}3 python {{{3
Add_rules(
  {filetype: 'python', char: '(', input: '('},
  [
    # http://qiita.com/hatchinee/items/c5bc19a656925ce33882
    # classとかの定義時に:までを入れる
    {at: '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#', input_after: '):'},
    # すでに:がある場合は重複させない. (smartinputでは、atの定義が長いほど適用の優先度が高くなる)
    {at: '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#.*:', input_after: ')'},
  ]
)

# 末尾:の手前でも、エンターとか:で次の行にカーソルを移動させる
Add_rules(
  {
    at: '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#:$',
    input: '<Right><CR>',
    filetype: 'python',
  },
  [
    {char: ':'},
    {char: '<CR>'},
  ]
)

Add_rules(
  {filetype: 'python'},
  [
    # (): を一度に消す
    {at: '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+(\%#):$', char: '<BS>', input: '<BS>', delete: 2},
    # デフォルト引数の場合は=の前後にスペースを入力しない
    {at: '\w\+(\n\=\([^)]\+\n\)*[^)]\+\%#', char: '='},
  ]
)

Add_rules(
  {filetype: 'python', char: '<CR>'},
  [
    # ' = 'の後に改行したら'\'を入力
    {at: ' = \%#', input: '\<CR>'},
    # クオート内改行では'\'を入力しない
    {at: "'.* = \%#'"},
    {at: '".* = \%#"'},
  ]
)

# }}}3 markdown {{{3
Add_rules(
  {filetype: 'markdown'},
  [
    # 改行後に末尾のスペースが2つ以上の場合は2つ残す
    {at: '\S\+\s\s\+\%#$', char: '<CR>', input: '<ESC>ciw<Space><Space><CR>'},
    # コード PRE shell の場合 プロンプト $ を自動入力
    {at: '```sh\n\(\n.*\)*\%#\(\n.*\)*```', char: '<CR>', input: '<CR>$<Space>'},
    # コード PRE shell の場合 行頭スペースでプロンプト $ を自動入力
    {at: '```sh\(\n.*\)*\n\%#\(\n.*\)*```', char: '<Space>', input: '$<Space>'},
    # コード PRE shell の場合 プロンプト $ を一括削除
    {at: '```sh\(\n.*\)*$ \%#\(\n.*\)*```', char: '<BS>', input: '<BS><BS>'},
  ]
)

# }}}3 html, xml {{{3
Add_rules(
  {filetype: ['html', 'xml']},
  [
    {char: '>', at: '<\(\w\+\)\%(\s\+\w\+=\".\+\"\)*\%#', input_after: '</\1>', with_submatch: 1},
    {char: '/', at: '<\(\w\+\)\(\s\+\w\+=\".\+\"\)*\%#', input: '>'},
    {char: '=', at: '\w\+\%#', input: '="', input_after: '"'},
  ]
)

# }}}3 others {{{3
lexima#add_rule({
  at: '``\%#',
  char: '`',
  input: '',
  input_after: '``',
  filetype: 'rst'
})

# =の前後にスペースを入れない
lexima#add_rule({
  at: '.\%#',
  char: '=',
  filetype: ['rst', 'sh']
})

# == -> :=
lexima#add_rule({
  at: ' == \%#',
  char: '=',
  input: '<BS><BS><BS>:=<Space>',
  filetype: 'autohotkey',
})

lexima#add_rule({
  char: '`',
  filetype: 'autohotkey',
})

# }}}3
# }}}2
# }}}1
