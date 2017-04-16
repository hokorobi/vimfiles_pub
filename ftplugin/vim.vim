scriptencoding utf-8

" plugin {{{1

" lexima

" set 系コマンドでは = の間にスペースを入れない
call lexima#add_rule({
      \   'at'      : '^set.*\%#',
      \   'char'    : '=',
      \   'filetype': ['vim'],
      \})

" https://github.com/cohama/lexima.vim/issues/33
""{{{|%#}}}
" ↓
" "{{{
" "}}}
call lexima#add_rule({
      \   'at': '{{{\%#}}}',
      \   'char': '<CR>',
      \   'input_after': '',
      \   'priority': 1,
      \   'filetype': 'vim',
      \})

" Vim scriptで以下のようなインデントをする {{{2
" NeoBundleLazy 'cohama/lexima.vim', {
" \   'autoload': {
" \       'insert': 1
" \   }
" \}

if &l:shiftwidth == 0
    let s:indent = &l:tabstop
else
    let s:indent = &l:shiftwidth
endif

" 改行時に \ 入力
for s:val in ['{:}', '\[:\]']
  let s:pair = split(s:val, ':')

  " {\%#}
  " ↓
  " {
  " \   \%#
  " \}
  call lexima#add_rule({
        \   'at'         : s:pair[0] . '\%#' . s:pair[1],
        \   'char'       : '<CR>',
        \   'input'      : '<CR><Bslash>   ',
        \   'input_after': '<CR><Bslash>',
        \   'filetype'   : 'vim',
        \})

  " indent 5つ分まで設定
  for s:i in range(1, 5)
    let s:space_num = s:indent * s:i - 1
    let s:space = ''
    for s:j in range(s:space_num + s:indent)
      let s:space = s:space . ' '
    endfor
    let s:space_after = ''
    for s:j in range(s:space_num)
      let s:space_after = s:space_after . ' '
    endfor

    " \   {\%#}
    " ^^^^ shiftwidthの倍数 - 1の長さ
    " ↓
    " \   {
    " \       \%#
    " \   }
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' . s:space_num . '\}.*' . s:pair[0] . '\%#' . s:pair[1],
          \   'char'       : '<CR>',
          \   'input'      : '<CR><Bslash>' . s:space,
          \   'input_after': '<CR><Bslash>' . s:space_after,
          \   'filetype'   : 'vim',
          \})
    " \   hoge, \%#
    " ^^^^ shiftwidthの倍数 - 1の長さ
    " ↓
    " \   hoge,
    " \   \%#
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' . s:space_num . '\}.*\%#',
          \   'char'       : '<CR>',
          \   'input'      : '<CR><Bslash>' . s:space_after,
          \   'filetype'   : 'vim',
          \})
    " 末尾スペース削除
    call lexima#add_rule({
          \   'at'         : '^\s*\\\s\{' . s:space_num . '\}.*\s\+\%#',
          \   'char'       : '<CR>',
          \   'input'      : '<Esc>diwo<Bslash>' . s:space_after,
          \   'filetype'   : 'vim',
          \})
  endfor
endfor
"}}}2

" }}}1
