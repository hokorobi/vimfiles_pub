" hook_add {{{
call textra#setup({
    \ 'name': g:textraName,
    \ 'key': g:textraApiKey,
    \ 'secret': g:textraApiSecret,
    \ })

function s:display_result(result) abort
  for s in split(a:result, "。")
    echomsg s
  endfor
  " FIXME: topleft が反映されないみたい
  " call popup_atcursor(a:result, #{
  "     \ pos: 'topleft',
  "     \ line: 'cursor-1',
  "     \ col: 'cursor',
  "     \ moved: 'WORD',
  "     \ })
endfunction

function s:cmd_translate(from_lang, to_lang, reg = '') abort
  echo '[textra] translate ...'
  let src = getreg(a:reg)->substitute('[[:space:]]\+', ' ', 'g')
  let dst = textra#translate(src, a:from_lang, a:to_lang)
  call s:display_result(dst)
endfunction

function s:wrap_translate() abort
  " save current z register
  let save_reg = getreginfo('z')

  if mode() !~# '^[vV\x16]'
    " not in visual mode
    noautocmd normal! 0"zy$
  else
    " get selection through z register
    noautocmd normal! "zygv
  endif

  call s:cmd_translate('en', 'ja', 'z')

  " restore z register
  call setreg('z', save_reg)
endfunction

command! Textra call s:wrap_translate()

BulkMap nx <Space>tt <Cmd>Textra<CR>
" }}}
