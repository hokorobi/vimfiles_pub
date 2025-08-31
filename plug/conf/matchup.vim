" hook_add {{{
let g:loaded_matchit = 1

" sandwich の ib ab を使うため ds% cs% は無効にする
let g:matchup_surround_enabled = 0

" popup で表示
let g:matchup_matchparen_offscreen = #{method: 'popup'}

" 関数内部の return などに移動せず関数先頭と末尾を行き来する。
let g:matchup_delim_nomids = 1

BulkMap nxo <expr> <Space><Space> getline('.')[col('.') - 1] =~ "['\"]" ? lazy#PercentExpr() : '<Plug>(matchup-%)'
" }}}
