scriptencoding utf-8

" = の間にスペースを入れない
call lexima#add_rule({
      \   'at'      : '\%#',
      \   'char'    : '=',
      \   'filetype': ['sh'],
      \})
