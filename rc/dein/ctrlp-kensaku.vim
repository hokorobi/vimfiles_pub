" hook_add {{{
nnoremap <Space>f/ <Cmd>CtrlPKensaku 'CtrlPLine'<CR>
nnoremap <Space>fq <Cmd>CtrlPKensaku 'CtrlPQuickfix'<CR>
" }}}
" hook_source {{{
function! s:kensaku(ctrlp) abort
  let l:oldmatcher = g:ctrlp_match_func
  let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
  execute(a:ctrlp)
  let g:ctrlp_match_func = l:oldmatcher
endfunction
command! -nargs=1 CtrlPKensaku call <SID>kensaku(<args>)
" }}}
