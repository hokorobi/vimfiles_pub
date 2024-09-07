" hook_source {{{
" FIXME: Windows で UTF-8 のファイルを文字化けせずにプレビューしたい。
" 環境変数で文字コードを指定すると標準エラー出力にメッセージを表示する用で、エラーとして扱われてしまう。
let $JDK_JAVA_OPTIONS = '-Dfile.encoding=UTF-8'
let g:plantuml_previewer#plantuml_jar_path = g:plantuml_path
let g:plantuml_previewer#debug_mode = 1
" }}}
