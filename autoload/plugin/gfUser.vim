scriptencoding utf-8

" http://d.hatena.ne.jp/thinca/20140324/1395590910
" Windows foo.c:23 などでも gf で foo.c を開けるようにする
function plugin#gfUser#file() abort
  let path = expand('<cfile>')
  let line = 0
  if path =~# ':\d\+:\?$'
    let line = matchstr(path, '\d\+:\?$')
    let path = matchstr(path, '.*\ze:\d\+:\?$')
  endif
  let path = findfile(path, $'{getcwd()};')  " 追加
  if !filereadable(path)
    return 0
  endif
  return #{
        \   path: path,
        \   line: line,
        \   col:  0,
        \ }
endfunction
