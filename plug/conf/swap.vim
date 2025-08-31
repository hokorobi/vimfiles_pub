" hook_add {{{
BulkMap xo i, <Plug>(swap-textobject-i)
BulkMap xo a, <Plug>(swap-textobject-a)

" 行内の要素をソートする
command! SortLine execute 'normal gss<ESC>'

"cheatsheet-echo
let s:tips = [
      \   'gs	swap mode へ。(j/k: 対象選択、h/l: 対象移動、s/S: ソート昇順/降順、r: 反転、g/G: グループ化/解除)',
      \   'g> / g<	要素を右/左に移動',
      \   ':SortLine	行内の要素をソート',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'swap')

" }}}
" hook_source {{{
" タブ区切りも要素とする。
let g:swap#rules = deepcopy(g:swap#default_rules)
let g:swap#rules += [#{
      \   delimiter: ['\t'],
      \   body: '\h\w*\(\t\h\w*\)\+',
      \ }]
" }}}
