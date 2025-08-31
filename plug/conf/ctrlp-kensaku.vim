" hook_add {{{
nnoremap <Space>f/ <Cmd>CtrlPKensaku 'CtrlPLine'<CR>
nnoremap <Space>fq <Cmd>CtrlPKensaku 'CtrlPQuickfix'<CR>
nnoremap [toggle]c <Cmd>ToggleCtrlPKensaku<CR>
" }}}
" hook_source {{{
let g:kensaku_dictionary_cache = '~/_vim/kensaku.vim/migemo-compact-dict'

function s:kensaku(ctrlp) abort
  let l:oldmatcher = g:ctrlp_match_func
  let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
  execute(a:ctrlp)
  let g:ctrlp_match_func = l:oldmatcher
endfunction
command! -nargs=1 CtrlPKensaku call <SID>kensaku(<args>)

function s:togglekensaku() abort
  if g:ctrlp_match_func.match ==# 'ctrlp_kensaku#matcher'
    let g:ctrlp_match_func.match = g:ctrlp_kensaku_ols_matcher
  else
    let g:ctrlp_kensaku_ols_matcher = g:ctrlp_match_func.match
    let g:ctrlp_match_func.match = 'ctrlp_kensaku#matcher'
  endif
  echo $'CtrlP matcher: {g:ctrlp_match_func.match}'
endfunction
command! -nargs=0 ToggleCtrlPKensaku call <SID>togglekensaku()
" }}}
