scriptencoding utf-8

call lexima#set_default_rules()

"Hg cim -> Hg ci -m ""
call lexima#add_rule({
      \   'at'   : 'Hg ci\%#',
      \   'char' : 'm',
      \   'input': ' -m ""<Left>',
      \   'mode' : ':',
      \})

" http://qiita.com/yami_beta/items/26995a5c382bd83ac38f
inoremap <C-f> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" https://github.com/awaman/dotfiles/blob/master/.vim/rc/lexima.vim
" 改行後に末尾のスペースを消す
call lexima#add_rule({
      \   'at'   : '\S\+\s\+\%#$',
      \   'char' : '<CR>',
      \   'input': '<Esc>diwo',
      \})

for c in [',']
  " 後にスペースを入れる
  call lexima#add_rule({
        \   'at'   : '\%#',
        \   'char' : c,
        \   'input': c . '<Space>',
        \})
  " 後にスペースを続けられないようにする
  call lexima#add_rule({
        \   'at'   : c . ' \%#',
        \   'char' : '<Space>',
        \   'input': '',
        \})
  " 一度に削除する
  call lexima#add_rule({
        \   'at'   : '\S\+' . c . ' \%#',
        \   'char' : '<BS>',
        \   'input': '<BS><BS>',
        \})
endfor

" =の前後にスペースを入れる
call lexima#add_rule({
      \   'at'   : '\w\+\%#',
      \   'char' : '=',
      \   'input': '<Space>=<Space>',
      \})

" =入力前にスペースがあったら入力しない
call lexima#add_rule({
      \   'at'   : '\w\+ [-+\\*/%=]\=\%#',
      \   'char' : '=',
      \   'input': '=<Space>',
      \})

" ' = 'の後ろにスペースをいれ続けない
call lexima#add_rule({
      \   'at'   : '\w\+ [-+\\*/%=]\==\+ \%#',
      \   'char' : '<Space>',
      \   'input': '',
      \})

" ==の場合は1つスペースを消す
call lexima#add_rule({
      \   'at'   : '\w\+ =\+ \%#',
      \   'char' : '=',
      \   'input': '<BS>=<Space>',
      \})

" 演算子直後の=
call lexima#add_rule({
      \   'at'   : '\w\+[-+\\*/%=]\%#',
      \   'char' : '=',
      \   'input': '<Left> <Right>=<Space>',
      \})

" ' = 'を一度に消す
call lexima#add_rule({
      \   'at'   : '\w\+ = \%#',
      \   'char' : '<BS>',
      \   'input': '<BS><BS><BS>',
      \})

" ' == ', ' += '等を一度に消す
call lexima#add_rule({
      \   'at'   : '\w\+ [-+\\*/%=]= \%#',
      \   'char' : '<BS>',
      \   'input': '<BS><BS><BS><BS>',
      \})

" <BS>空白(インデント)を一気に削除
" call lexima#add_rule({
"       \   'at': '^\s\+\%#$',
"       \   'char': '<BS>',
"       \   'input': '<ESC>kJDA',
"       \})

" docstring の改行
for c in ["'", '"']
  call lexima#add_rule({
        \   'at'         : c . '\{3}.*\%#' . c . '\{3}',
        \   'char'       : '<CR>',
        \   'input_after': '<CR>',
        \})
endfor

