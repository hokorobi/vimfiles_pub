" hook_add {{{
call extend(g:vimrc_altercmd_dic, #{
      \   gin: 'Gin',
      \ })

nnoremap <Space>gaD <Cmd>GinPatch ++opener=tabnew %<CR>
" nnoremap <Space>gbr <Cmd>GinBranch --all<CR>
nnoremap <Space>g<M-d> <Cmd>GinDiff ++opener=tabnew<CR>
nnoremap <Space>gL <Cmd>GinLog --all --graph --max-count=100 --oneline --decorate<CR>
" nnoremap <Space>gL <Cmd>GinLog --all --patch --graph --max-count=100<CR>
nnoremap <Space>gS <Cmd>GinStatus<CR>
" 開いているファイル、選択行を Github で開く
BulkMap nx <Space>oG <Cmd>GinBrowse<CR>
BulkMap nx <Space>go <Cmd>GinBrowse<CR>
" <Cmd><CR>でくくると xmap で選択範囲がコピーできない
BulkMap nx <Space>gy :GinBrowse ++yank=+ -n<CR>

" }}}
" hook_source {{{
" !git の動作に支障をきたすため環境変数 GIT_EDITOR の書き換えを禁止
let g:gin_proxy_disable_editor = v:true

" デフォルトの vmap y は外したいため。
let g:gin_log_disable_default_mappings = v:true

" Gin.vim で表示しているファイルのその時点でのファイルを表示する GinLocal定義
function s:define_gin_local() abort
  command! -buffer -bar GinLocal execute 'edit' gin#util#expand('%')
endfunction
autocmd vimrc BufReadCmd ginedit://* call s:define_gin_local()
autocmd vimrc BufReadCmd gindiff://* call s:define_gin_local()
autocmd vimrc BufReadCmd ginlog://* call s:define_gin_local()

" Sayonara
let g:sayonara_filetypes.gin = 'bdelete'

function GinCR()
  if v:count > 0
    execute $'normal! {v:count}G'
  else
    execute join(['!git show -r', expand('<cword>')])
  endif
endfunction

let s:tips = [
      \ '',
      \ '[GinPatch]',
      \ 'dp  左か右のバッファで実行して中央へ反映',
      \ 'dor 中央のバッファで実行して右の内容を反映',
      \ 'dol 中央のバッファで実行して左の内容を反映',
      \ '',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'gin')
" }}}
" gin {{{
nnoremap <buffer> <CR> <Cmd>call GinCR()<CR>
nnoremap <expr><buffer> <Space><CR> printf('<Cmd>GinBuffer show ++opener=split -r %s<CR>', expand('<cword>'))
" }}}
" gin-log {{{
map <buffer><nowait> a <Plug>(gin-action-choice)
map <buffer><nowait> . <Plug>(gin-action-repeat)
nmap <buffer><nowait> ? <Plug>(gin-action-help)

map <buffer><nowait> <Return> <Plug>(gin-action-show)zv

nmap <buffer><nowait> yy <Plug>(gin-action-yank:commit)

nnoremap <buffer> qq <Cmd>close<CR>
" }}}
" gitcommit {{{
nnoremap <buffer> <Space>gl <Cmd>GinLog ++opener=vsplit --max-count=100 --oneline --decorate<CR>
" }}}
