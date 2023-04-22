" hook_add {{{
call extend(g:vimrc_altercmd_dic, #{
      \   gin: 'Gin',
      \ })

nnoremap <Space>gbr <Cmd>GinBranch --all<CR>
nnoremap <Space>gD <Cmd>GinDiff ++opener=tabnew<CR>
nnoremap <Space>gl <Cmd>GinLog ++opener=tabnew --all --graph --max-count=100 --oneline --decorate<CR>
nnoremap <Space>gL <Cmd>GinLog --all --patch --graph --max-count=100<CR>
nnoremap <Space>gaD <Cmd>GinPatch ++opener=tabnew %<CR>
" 指定したコミット、ブランチのファイルを表示。
" call util#addLeft('nnoremap <Space>gbo :GinEdit ++opener=vsplit ', ' %')
" }}}
" hook_source {{{
" !git の動作に支障をきたすため環境変数 GIT_EDITOR の書き換えを禁止
let g:gin_proxy_disable_editor = v:true

" Sayonara
let g:sayonara_filetypes.gin = 'bdelete'

function! GinCR()
  if v:count > 0
    execute printf('normal! %iG', v:count)
  else
    execute join(['!git show -r', expand('<cword>')])
  endif
endfunction
" }}}
" gin {{{
nnoremap <buffer> <CR> <Cmd>call GinCR()<CR>
nnoremap <expr><buffer> <Space><CR> printf('<Cmd>GinBuffer show ++opener=split -r %s<CR>', expand('<cword>'))
" }}}
" gitcommit {{{
nnoremap <buffer> <Space>gl <Cmd>GinLog ++opener=vsplit --max-count=100 --oneline --decorate<CR>
" }}}
