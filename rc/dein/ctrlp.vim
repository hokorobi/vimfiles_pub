" hook_add {{{
let g:ctrlp_map = '<Nop>'

" 候補の残りにあわせてリサイズしない
let g:ctrlp_match_window = 'bottom,order:btt,min:2,max:20'

" Guess vcs root dir
let g:ctrlp_working_path_mode = 'ra'

" Open current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = 'r'

" cache files directory
let g:ctrlp_cache_dir = expand('~/_vim/.ctrlp')

let g:ctrlp_switch_buffer = 0

let g:ctrlp_regexp = 0

let g:ctrlp_show_hidden = 1
" exculde mru
let g:ctrlp_mruf_exclude = '^C:\\Users\\.*\\AppData\\Local\\Temp\\.*'

let g:ctrlp_custom_ignore = #{
  \ dir:  '\v[\/](\.(bzr|git|hg|svn)|node_modules|_venv)$',
  \ file: '\v\.(dll|exe|so)$',
  \ link: 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

let g:ctrlp_open_single_match = ['buf']

" mapping
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>', '<m-m>'],
      \ 'PrtSelectMove("j")'  : ['<c-j>', '<down>', '<m-j>'],
      \ 'PrtSelectMove("k")'  : ['<c-k>', '<up>', '<m-k>'],
      \ 'PrtBS()'             : ['<bs>', '<c-]>', '<c-h>'],
      \ 'PrtCurLeft()'        : ['<c-b>', '<left>', '<c-^>'],
      \ 'ToggleType(-1)'      : ['<c-down>'],
      \ 'PrtCurRight()'       : ['<c-f>', '<c-l>', '<right>'],
      \ 'ToggleType(1)'       : ['<c-up>'],
      \ 'PrtInsert("c")'      : ['<c-v>', '<MiddleMouse>', '<insert>'],
      \ 'PrtDelete()'         : ['<c-d>', '<del>'],
      \ 'PrtDeleteWord()'     : ['<c-q>'],
      \ 'ToggleByFname()'     : ['<F8>'],
      \ 'AcceptSelection("v")': ['<RightMouse>'],
      \ 'PrtDeleteEnt()'      : ['<F7>', '<c-w>'],
      \ }

" FIXME: <Space>fr で候補が出なくなる。
" let g:ctrlp_user_command = ['.git', 'git ls-files -co --exclude-standard']

nnoremap <Space>b <Cmd>CtrlPBuffer<CR>
" nnoremap <Space>f/ <Cmd>CtrlPLine<CR>
nnoremap <Space>fo <Cmd>call plugin#ctrlp#defaultInput('CtrlPLine', '{{{ ')<CR>
nnoremap <Space>*  <Cmd>call plugin#ctrlp#defaultInput('CtrlPLine', expand('<cword>') .. ' ')<CR>
xnoremap <Space>*  <Cmd>call plugin#ctrlp#defaultInput('CtrlPLine', vimrc#get_current_selection() .. ' ')<CR>
nnoremap <Space>u  <Cmd>CtrlPMRUFiles<CR>
nnoremap <Space>ff <Cmd>CtrlP<CR>
" nnoremap <Space>fq <Cmd>CtrlPQuickfix<CR>
" nnoremap <Space>fr <Cmd>call plugin#ctrlp#repository('n')<CR>
xnoremap <Space>fr <Cmd>call plugin#ctrlp#repository('x')<CR>

" CtrlP-funky だとカレントのバッファしか対象にできないので
nnoremap <Space>fu <Cmd>call Funcquickfix()<CR>
function Funcquickfix() abort
  if exists(':FuncGrep') == 0
    echomsg ':FuncGrep が未定義の filetype です。'
    return
  endif

  FuncGrep
  " QuickfixCmdPost で QuickFix が自動で開くので閉じる
  cclose
  CtrlPQuickfix
endfunction
" }}}
" rst {{{
nnoremap <buffer> <Space>fo <Cmd>call plugin#ctrlp#defaultInput('CtrlPLine', 'list-table ')<CR>
" }}}
" go {{{
command! -buffer -nargs=0 FuncGrep :execute 'vimgrep /^\s*func\s\+/j **/*.go'
" }}}
" javascript {{{
command! -buffer -nargs=0 FuncGrep :execute 'vimgrep /^\s*function\s\+/j **/*.js **/*.js9'
" }}}
" vim {{{
command! -buffer -nargs=0 FuncGrep :execute 'vimgrep /^\s*fu\%[nction]!\?\s\+\zs[a-zA-Z0-9_#:]\+\ze\s*(/j **/*.vim'
" }}}
" toml {{{
nnoremap <buffer> <Space>fg <Cmd>call plugin#ctrlp#defaultInput('CtrlPLine', 'repo= ')<CR>
" }}}
