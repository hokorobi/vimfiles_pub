scriptencoding utf-8

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

