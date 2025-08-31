" -t 自動折返し止め
" -c 自動折返して、現在のコメント開始文字列を自動挿入はやめ
" +j コメントリーダーを除いて連結
" +M マルチバイトの連結は空白なし
" _ {{{
setlocal formatoptions& formatoptions-=t formatoptions-=c formatoptions+=jM
" }}}

" changelog {{{
nnoremap <buffer> <Space>i <Cmd>NewChangelogEntry<CR>
" }}}

" diff {{{
nnoremap <buffer> qq <Cmd>diffoff<CR>
" }}}

" help {{{
" Vim ヘルプファイル編集用設定反映
command! HelpEditToggle call s:helpedittoggle()
" https://github.com/Shougo/shougo-s-github/blob/bd8eeac18d8eb99c2db7f1edef443ff49016551e/vim/rc/deinft.vim#L136-L154
function! s:align_right(linenr) abort
  let m = a:linenr->getline()->matchlist('^\(\S\+\%(\s\S\+\)\?\)\?\s\+\(\*.\+\*\)')
  if m->empty()
    return
  endif
  call setline(a:linenr, $'{m[1]} '->repeat(&l:textwidth - len(m[1]) - len(m[2])) .. m[2])
endfunction
function! s:align_rights(start, end) abort
  for linenr in range(a:start, a:end)
    call s:align_right(linenr)
  endfor
endfunction

function! s:set_highlight(group) abort
  for group in ['helpBar', 'helpBacktick', 'helpStar', 'helpIgnore']
    execute 'highlight link' group a:group
  endfor
endfunction

" ycino@vim-jp slack
function s:helpedittoggle() abort
  if &conceallevel == 0
    edit!
    return
  endif

  setlocal buftype= modifiable noreadonly
  setlocal list tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78
  setlocal colorcolumn=+1
  setlocal conceallevel=0

  call s:set_highlight('Special')

  " ヘルプ関連タグの右揃え
  command! -range -buffer AlignRight call s:align_rights('<line1>'->expand(), '<line2>'->expand())
  nnoremap <silent><buffer> mm <Cmd>AlignRight<CR>
  xnoremap <silent><buffer> mm :AlignRight<CR>
endfunction
" }}}

" json {{{
setlocal conceallevel=0
setlocal equalprg=jj\ -p
" }}}

" qf {{{
setlocal nobuflisted
nnoremap <buffer> <CR> <CR>
nnoremap <buffer> <Space>j <Cmd>cnfile<CR>
nnoremap <buffer> <Space>k <Cmd>cpfile<CR>

" pt で grep を実行した後に結果をパス順にしたかったので sort
" QuickFixCmdPost で実行していたけど w:quickfix_title が常に setqflist() になってしまうのでやめ。
" http://stackoverflow.com/questions/15393301/automatically-sort-quickfix-entries-by-line-text-in-vim
nnoremap <buffer>         sq <Cmd>call lazy#SortQuickfix()<CR>
" TODO: Set keymap
nnoremap <buffer><silent> <S-j> :<C-u>call <SID>older()<CR>
nnoremap <buffer><silent> <S-k> :<C-u>call <SID>newer()<CR>
let s:tips = [
      \ '<S-j> older',
      \ '<S-k> newer',
      \ 'p     preview',
      \ 'sq    sort',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'qf')
nnoremap <buffer><silent> ? <Cmd>call cheatsheetecho#CheatSheetEcho(v:true)<CR>

" https://github.com/lambdalisue/dotfiles/blob/e1b1e1017c3764684da3a92d77f9745bb3aa8474/.config/nvim/after/ftplugin/qf.vim
function! s:is_quickfix()  abort
  return getwininfo(win_getid())[0].quickfix
endfunction

if !exists('*s:older')
  function! s:older() abort
    try
      if s:is_quickfix()
        colder
      else
        lolder
      endif
    catch
      echohl ErrorMsg
      echo substitute(v:exception, 'Vim(.*):', '', '')
      echohl None
    endtry
  endfunction
endif

if !exists('*s:newer')
  function! s:newer() abort
    try
      if s:is_quickfix()
        cnewer
      else
        lnewer
      endif
    catch
      echohl ErrorMsg
      echo substitute(v:exception, 'Vim(.*):', '', '')
      echohl None
    endtry
  endfunction
endif

" }}}

" rst {{{
setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=0
" }}}

" toml {{{
setlocal nocindent
setlocal expandtab shiftwidth=2 tabstop=4 softtabstop=2
" }}}

" vim {{{
" 一旦やめてみる
" : を \k などに含める。s:hoge を単語として扱った方が便利なことが多いので
" iW などでいいかも？　と思ったけど、func(g:hoge とかは先頭まで対象になるから駄目だ。
" setlocal iskeyword+=58
setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
" }}}

