function! util#addLeft(lhs, rhs, add = 0)
  execute printf('%s%s%s', a:lhs, a:rhs, repeat('<Left>', len(a:rhs)+a:add))
endfunction

