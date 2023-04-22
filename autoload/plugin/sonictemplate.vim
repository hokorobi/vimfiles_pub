scriptencoding utf-8

function! plugin#sonictemplate#editHowmNew(dir) abort
  let dir = a:dir .. strftime('/%Y/%m')
  if isdirectory(dir) == 0
    call mkdir(dir, 'p')
  endif
  let file = strftime('/%Y%m%d%H%M%S.howm')
  execute printf('edit %s%s', dir, file)
  Template howm
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

function! plugin#sonictemplate#editHowmNewTodo(dir = g:howm_dir .. "/todo") abort
  let file = strftime('/%Y-%m-%d-%H%M%S.howm')
  execute printf('edit %s%s', a:dir, file)
  Template howmtodo
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

" vim-jp slack 2021-11-02 Hasu
" テンプレート候補をポップアップで表示
" function! s:sonictemplateSelector() abort
"     let s:candidate = getcompletion('Template ', 'cmdline')
"     call popup_menu(s:candidate,#{callback: function('s:sonictemplateSelector_apply')})
" endfunction
" function! s:sonictemplateSelector_apply(id,result) abort
"     if s:candidate[a:result] ==# ' '
"         return
"     endif
"     exec printf(":Template %s",s:candidate[a:result])
" endfunction

