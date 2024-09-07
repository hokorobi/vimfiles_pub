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

call extend(g:vimrc_altercmd_dic, {
      \   'cap[ture]': 'Capture',
      \   'ml': 'Capture messages',
      \   'scriptn\%[ames]': 'Capture scriptnames',
      \ })

" }}}
" hook_source {{{
let g:capture_override_buffer = 'replace'

" Sayonara
let g:sayonara_filetypes.capture = 'bdelete'
" }}}
