scriptencoding utf-8

" plugin {{{1

" lexima
" = の間にスペースを入れない
call lexima#add_rule({
      \   'at'      : '\%#',
      \   'char'    : '=',
      \   'filetype': ['sh'],
      \})

" }}}1
