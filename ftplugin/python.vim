scriptencoding utf-8

" plugin {{{1

" lexima

" http://qiita.com/hatchinee/items/c5bc19a656925ce33882
" classとかの定義時に:までを入れる
call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#',
      \   'char'    : '(',
      \   'input'   : '():<Left><Left>',
      \   'filetype': ['python'],
      \   })

" すでに:がある場合は重複させない. (smartinputでは、atの定義が長いほど適用の優先度が高くなる)
call lexima#add_rule({
      \   'at'      : '^\s*\%(\<def\>\|\<if\>\|\<for\>\|\<while\>\|\<class\>\|\<with\>\)\s*\w\+.*\%#.*:',
      \   'char'    : '(',
      \   'input'   : '()<Left>',
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
      \   'input'   : '<BS><Del><Del>',
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

" }}}1
