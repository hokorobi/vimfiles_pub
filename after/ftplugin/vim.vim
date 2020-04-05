scriptencoding utf-8

" : を \k などに含める。s:hoge を単語として扱った方が便利なことが多いので
" iW などでいいかも？　と思ったけど、func(g:hoge とかは先頭まで対象になるから駄目だ。
setlocal iskeyword+=58

setlocal formatoptions& formatoptions+=M formatoptions-=t formatoptions-=c formatoptions+=j

