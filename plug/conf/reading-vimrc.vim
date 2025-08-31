" hook_add {{{
call extend(g:vimrc_altercmd_dic, #{
      \ readc: 'ReadingVimrcCopy',
      \ readl: 'ReadingVimrcLoad',
      \ readn: 'ReadingVimrcNext',
      \ })
" }}}
" hook_source {{{
" https://github.com/Omochice/dotfiles/blob/main/config/nvim/rc/lazy.toml?plain=1#L246-L255
function! s:reading_copy(line1, line2) abort
  " NOTE: 4 is ['next', {owner}, {repo}, {branch}]
  const l:file = expand('%')->substitute('readingvimrc:\/\/\([^/]\{1,\}/\)\{4\}', '', '')
  const l:line = a:line1 == a:line2
        \ ? $'L{a:line1}'
        \ : $'L{a:line1}+{a:line2 - a:line1}'
  call input('', $'{l:file}#{l:line} ')->setreg('+')
endfunction

command! -range ReadingVimrcCopy call <SID>reading_copy(<line1>, <line2>)
nnoremap <M-y> <Cmd>ReadingVimrcCopy<CR>

" cheatsheet-echo
let s:tips = [
      \   ':ReadingVimrcCopy	vimrc読書会へ投稿する内容をコピー',
      \   '<M-y>	vimrc読書会へ投稿する内容をコピー',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'reading-vimrc')
" }}}
