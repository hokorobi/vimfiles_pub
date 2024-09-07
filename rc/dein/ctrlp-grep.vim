" hook_add {{{
const g:ctrlp_grep_command = 'pt /nogroup /nocolor /hidden /home-ptignore /S /U'
nnoremap <expr> <Space>fz $'<Cmd>CtrlPGrep title {expand("~/Documents/zenn/articles")}<CR>'
" }}}
