setlocal shiftwidth=2 tabstop=2 expandtab

" ' はコメントなのでそのまま入力
call lexima#add_rule({
      \   'at'   : '\%#',
      \   'char' : "'",
      \})