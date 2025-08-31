" hook_source {{{
" sign に texthl を設定していると next, previous でチラつく
let g:qfpreview = #{
      \    top: 'g',
      \    bottom: 'G',
      \    scrollup: 'p',
      \    scrolldown: 'n',
      \    halfpageup: 'u',
      \    halfpagedown: 'd',
      \    fullpageup: 'b',
      \    fullpagedown: 'f',
      \    next: 'j',
      \    previous: 'k',
      \    number: v:true,
      \    sign: #{
      \      numhl: 'Search',
      \    },
      \ }
" }}}
" qf {{{
" FIXME 動かなくなっている
nnoremap <buffer> p <plug>(qf-preview-open)
" }}}
