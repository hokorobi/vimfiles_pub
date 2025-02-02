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

" gitcommit {{{
startinsert
" }}}

" help {{{
" Vim ヘルプファイル編集用設定反映
command! HelpEditToggle call vimrc#helpedittoggle()
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
nnoremap <buffer> sq <Cmd>call vimrc#SortQuickfix('vimrc#QfStrCmp')<CR>
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

