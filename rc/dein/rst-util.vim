" rst {{{
nnoremap <buffer> <Space><Space>1 <Plug>(rst-section1)
nnoremap <buffer> <Space><Space>2 <Plug>(rst-section2)
nnoremap <buffer> <Space><Space>3 <Plug>(rst-section3)
nnoremap <buffer> <Space><Space>4 <Plug>(rst-section4)
nnoremap <buffer> <Space><Space>5 <Plug>(rst-section5)
nnoremap <buffer> <Space><Space>6 <Plug>(rst-section6)

inoremap <buffer> <C-CR> <Plug>(rst-insert-samebullet)
inoremap <buffer> <S-CR> <Plug>(rst-insert-childbullet)
inoremap <buffer> <C-S-CR> <Plug>(rst-insert-parentbullet)

inoremap <buffer> <M-CR> <Plug>(rst-insert-lineblock)
" }}}
