" hook_source {{{
let g:rengbang_default_start = 1
call extend(g:vimrc_altercmd_dic, {
      \ 'ren\%[gbang]': 'RengBang',
      \ })
call cheatsheetecho#CheatSheetEchoAdd(['', '[rengbang]', ':RengBang	選択範囲の数字を1からの連番に。'], '_', 'rengbang')
" }}}
