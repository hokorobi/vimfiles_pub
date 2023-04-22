scriptencoding utf-8

function! plugin#ctrlp#repository(mode) abort
  let repo = vimrc#getRepositoryName(a:mode)
  if repo ==# ''
    execute printf('CtrlP ~/_vim/dein/repos/github.com')
    return
  endif

  let isRepo = input(printf('CtrlP %s ? [Y/n]', repo))
  if isRepo ==# '' || isRepo ==# 'y' || isRepo ==# 'Y'
    execute printf('CtrlP ~/_vim/dein/repos/github.com/%s', repo)
  endif
endfunction

" CtrlP のコマンドと初期入力値を指定して実行
function! plugin#ctrlp#defaultInput(cmd, input)
  try
    let l:default_input_save = get(g:, 'ctrlp_default_input', '')
    let g:ctrlp_default_input = a:input
    execute a:cmd
  finally
    if exists('l:default_input_save')
      let g:ctrlp_default_input = l:default_input_save
    endif
  endtry
endfunction

