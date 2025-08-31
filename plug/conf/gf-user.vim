" hook_source {{{
" Windows でもfoo.c:23 などの行数指定の記述を gf で開けるようにする
" http://thinca.hatenablog.com/entry/20140324/1395590910
call gf#user#extend('GfFile', 1000)
function GfFile() abort
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
" }}}
