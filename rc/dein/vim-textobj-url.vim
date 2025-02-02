" hook_add {{{
nnoremap <Space>oo <Cmd>call <SID>openbrowser()<CR>
function! s:openbrowser() abort
  const backregz = getreginfo('z')
  call setreg('z', '')
  normal "zyiu
  const url = getreg('z')
  if url !=# ''
    echom url
    call vimrc#openbrowser(url)
  endif
  call setreg('z', backregz)
endfunction
" }}}
