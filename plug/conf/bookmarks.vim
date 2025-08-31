" hook_add {{{
" bookmark_auto_save_file が無効になるので g:bookmark_manage_per_buffer は 1 にしない
let g:bookmark_auto_save_file = expand('~/_vim/.vim-bookmarks')

let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'

" ブックマークを開いたら候補のウィンドウは閉じる
let g:bookmark_auto_close = 1

let g:bookmark_no_default_key_mappings = 1
nnoremap mm <Plug>BookmarkToggle
nnoremap mi <Plug>BookmarkAnnotate
nnoremap <Space>fm <Plug>BookmarkShowAll
nnoremap mj <Plug>BookmarkNext
nnoremap mk <Plug>BookmarkPrev
" }}}
