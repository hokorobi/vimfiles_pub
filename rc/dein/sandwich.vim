" hook_add {{{
let g:operator_sandwich_no_default_key_mappings = v:true

BulkMap nx s <Nop>

nnoremap sc  <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nnoremap scc <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nnoremap cs  <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nnoremap css <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
BulkMap xo sc <Plug>(operator-sandwich-replace)

nnoremap sr  <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nnoremap srr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
" nnoremap rss <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
BulkMap xo sr <Plug>(operator-sandwich-replace)

nnoremap sd  <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nnoremap sdd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nnoremap ds  <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nnoremap dss <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
BulkMap xo sd <Plug>(operator-sandwich-delete)

nnoremap saa <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
BulkMap nxo sa <Plug>(operator-sandwich-add)
" https://github.com/machakann/vimrc/blob/3dc16ac1ae31197e35bebdf3f0fbf275117478bd/.vimrc#L1127-L1152
nnoremap s( <Plug>(operator-sandwich-add-query1st)(
nnoremap s8 <Plug>(operator-sandwich-add-query1st)(
nnoremap s) <Plug>(operator-sandwich-add-query1st))
nnoremap s9 <Plug>(operator-sandwich-add-query1st))
xnoremap s( <Plug>(operator-sandwich-add)(
xnoremap s8 <Plug>(operator-sandwich-add)(
xnoremap s) <Plug>(operator-sandwich-add))
xnoremap s9 <Plug>(operator-sandwich-add))
nnoremap s[ <Plug>(operator-sandwich-add-query1st)[
nnoremap s] <Plug>(operator-sandwich-add-query1st)]
xnoremap s[ <Plug>(operator-sandwich-add)[
xnoremap s] <Plug>(operator-sandwich-add)]
nnoremap s{ <Plug>(operator-sandwich-add-query1st){
nnoremap s} <Plug>(operator-sandwich-add-query1st)}
xnoremap s{ <Plug>(operator-sandwich-add){
xnoremap s} <Plug>(operator-sandwich-add)}
nnoremap s" <Plug>(operator-sandwich-add-query1st)"
nnoremap s2 <Plug>(operator-sandwich-add-query1st)"
xnoremap s" <Plug>(operator-sandwich-add)"
xnoremap s2 <Plug>(operator-sandwich-add)"
nnoremap s' <Plug>(operator-sandwich-add-query1st)'
nnoremap s7 <Plug>(operator-sandwich-add-query1st)'
xnoremap s' <Plug>(operator-sandwich-add)'
xnoremap s7 <Plug>(operator-sandwich-add)'
nnoremap sf <Plug>(operator-sandwich-add-query1st)f
xnoremap sf <Plug>(operator-sandwich-add)f
" }}}
" hook_source {{{
let g:textobj#sandwich#stimeoutlen = 100

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
      \   #{buns: ['（', '）'], nesting: 1, input: ['j(', 'j)', 'jp']},
      \   #{buns: ['「', '」'], nesting: 1, input: ['j[', 'j]', 'jb']},
      \   #{buns: ['『', '』'], nesting: 1, input: ['j{', 'j}', 'jB']},
      \   #{buns: ['【', '】'], nesting: 1, input: ['j<', 'j>', 'jk']},
      \ ]

" function surrouding をコマンドラインモードでなくインサートモードで使う
" https://github.com/machakann/vim-sandwich/wiki/Magic-characters#function-surroundings
let g:sandwich#recipes += [
      \   #{
      \     buns: ['(', ')'],
      \     cursor: 'head',
      \     command: ['startinsert'],
      \     kind: ['add', 'replace'],
      \     action: ['add'],
      \     input: ['f']
      \   },
      \ ]

" 囲む範囲の両端のうち片方が空白ならそれを無視するように範囲を縮小
" saa を使うなら不要かも。
call operator#sandwich#set('add', 'char', 'skip_space', 1)
" }}}
