" hook_add {{{
call textra#setup({
    \ 'name': g:textraName,
    \ 'key': g:textraApiKey,
    \ 'secret': g:textraApiSecret,
    \ })

function s:display_result(result) abort
  " echomsg a:result
  call popup_atcursor(a:result, {})
endfunction

function s:cmd_translate(from_lang, to_lang, reg = '') abort
  echo '[textra] translate ...'
  let src = getreg(a:reg)->substitute('[[:space:]]\+', ' ', 'g')
  let dst = textra#translate(src, a:from_lang, a:to_lang)
  call s:display_result(dst)
endfunction

command! -nargs=+ Textra call s:cmd_translate(<f-args>)
" }}}
" hook_source {{{
" }}}

