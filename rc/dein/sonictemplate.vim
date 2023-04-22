" hook_add {{{
let g:sonictemplate_vim_template_dir = [
  \   '$HOME/vimfiles/rc/sonictemplate',
  \   '$HOME/_vim/dein/repos/github.com/mattn/vim-sonictemplate/template',
  \]

if exists('g:howm_dir') && isdirectory(g:howm_dir)
  nnoremap <Space>,c <Cmd>call plugin#sonictemplate#editHowmNew(g:howm_dir)<CR>
endif

autocmd vimrc FileType toml imap <buffer> <C-t> .plugin<C-R>=sonictemplate#postfix()<CR>
" }}}
