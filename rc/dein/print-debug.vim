" hook_source {{{
let g:print_debug_templates = #{
  \   go:         'fmt.Printf("+++ {}\n")',
  \   python:     'print(f"+++ {}")',
  \   javascript: 'console.log(`+++ {}`);',
  \   c:          'printf("+++ {}\n");',
  \   vim:        'echom "+++"',
  \ }
" }}}
