" hook_add {{{
command! Map   Capture map
command! Nmap  Capture nmap
command! Vmap  Capture vmap
command! Xmap  Capture xmap
command! Smap  Capture smap
command! Tmap  Capture tmap
command! Omap  Capture omap
command! Imap  Capture imap
command! Lmap  Capture lmap
command! Cmap  Capture cmap

nnoremap <expr> <M-c> <SID>addCaptureN()
function s:addCaptureN() abort
  let cmd = getreg(':')
  if stridx(cmd, 'Capture ') == 0
    return $':{cmd}'
  endif

  return $':Capture {cmd}'
endfunction

cnoremap <M-c> <Cmd>call <SID>addCaptureC()<CR>
function! s:addCaptureC() abort
  if stridx(getcmdline(), 'Capture ')
    call setcmdline($'Capture {getcmdline()}')
  endif
endfunction

call extend(g:vimrc_altercmd_dic, {
      \   'cap\%[ture]': 'Capture',
      \   'ml': 'Capture messages',
      \   'scriptn\%[ames]': 'Capture scriptnames',
      \ })

" }}}
" hook_source {{{
let g:capture_override_buffer = 'replace'

" Sayonara
let g:sayonara_filetypes.capture = 'bdelete'
" }}}
