" hook_source {{{
let g:plantuml_previewer#plantuml_jar_path = g:plantuml_path
" FIXME デバッグモードでないと画像の表示ができない
" https://github.com/weirongxu/plantuml-previewer.vim/issues/89
let g:plantuml_previewer#debug_mode = 1
let g:plantuml_previewer#plantuml_options = '-charset UTF-8'
" }}}
