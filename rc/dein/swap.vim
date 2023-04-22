" hook_add {{{
BulkMap xo i, <Plug>(swap-textobject-i)
BulkMap xo a, <Plug>(swap-textobject-a)

" 行内の要素をソートする
command! SortLine execute 'normal gss<ESC>'
" }}}
" hook_source {{{
" タブ区切りも要素とする。
let g:swap#rules = deepcopy(g:swap#default_rules)
let g:swap#rules += [#{
      \   delimiter: ['\t'],
      \   body: '\h\w*\(\t\h\w*\)\+',
      \ }]
" }}}
