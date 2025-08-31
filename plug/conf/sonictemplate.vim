" hook_add {{{
let g:sonictemplate_vim_template_dir = [
  \   '$HOME/vimfiles/plug/sonictemplate',
  \   '$HOME/_vim/dein/repos/github.com/mattn/vim-sonictemplate/template',
  \]

if exists('g:howm_dir') && isdirectory(g:howm_dir)
  nnoremap <Space>,c <Cmd>call SonictemplateEditHowmNew(g:howm_dir)<CR>
endif

autocmd vimrc FileType toml imap <buffer> <C-t> .plugin<C-r>=sonictemplate#postfix()<CR>
" }}}
" hook_source {{{
function SonictemplateEditHowmNew(dir) abort
  let dir = a:dir .. strftime('/%Y/%m')
  if isdirectory(dir) == 0
    call mkdir(dir, 'p')
  endif
  let file = strftime('/%Y%m%d%H%M%S.howm')
  execute $'edit {dir}{file}'
  Template howm
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

function SonictemplateEditHowmNewTodo(dir = $'{g:howm_dir}/todo') abort
  let file = strftime('/%Y-%m-%d-%H%M%S.howm')
  execute $'edit {a:dir}{file}'
  Template howmtodo
  " 行末尾追加でインサートモードへ
  startinsert!
endfunction

" vim-jp slack 2021-11-02 Hasu
" テンプレート候補をポップアップで表示
" function s:sonictemplateSelector() abort
"     let s:candidate = getcompletion('Template ', 'cmdline')
"     call popup_menu(s:candidate,#{callback: function('s:sonictemplateSelector_apply')})
" endfunction
" function s:sonictemplateSelector_apply(id,result) abort
"     if s:candidate[a:result] ==# ' '
"         return
"     endif
"     exec printf(":Template %s",s:candidate[a:result])
" endfunction

" }}}
