" hook_add {{{
let s:vim_suggest = {}
let s:vim_suggest.cmd = #{
    \ enable: v:true,
    \ pum: v:true,
    \ exclude: [],
    \ onspace: ['b\%[uffer]','colo\%[rscheme]'],
    \ alwayson: v:true,
    \ popupattrs: #{
    \   highlight: 'Normal',
    \   maxheight: 10,
    \},
    \ wildignore: v:true,
    \ addons: v:true,
    \ trigger: 't',
    \ reverse: v:false,
    \ prefixlen: 2,
\ }
let s:vim_suggest.keymap = #{
    \ page_up: ["\<PageUp>", "\<S-Up>"],
    \ page_down: ["\<PageDown>", "\<S-Down>"],
    \ hide: "\<C-e>",
    \ dismiss: "\<C-s>",
    \ send_to_qflist: "\<C-q>",
    \ send_to_arglist: "\<C-l>",
    \ send_to_clipboard: "\<C-g>",
    \ split_open: "\<C-j>",
    \ vsplit_open: "\<C-v>",
    \ tab_open: "\<C-t>",
\ }
autocmd vimrc VimEnter * call g:VimSuggestSetOptions(s:vim_suggest)
" }}}
