function! util#addLeft(lhs, rhs)
  execute printf('%s%s%s', a:lhs, a:rhs, repeat('<Left>', len(a:rhs)))
endfunction

