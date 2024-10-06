" hook_add {{{
nnoremap + <Plug>(clurin-next)
nnoremap - <Plug>(clurin-prev)
" }}}
" 設定に ''' が入っているので """ """ でくくらないと駄目。
" hook_source {{{
let g:clurin = {
      \   '-': #{
      \     use_default: 0,
      \     def: [
      \       ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
      \       ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'],
      \       ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      \       ['月', '火', '水', '木', '金', '土', '日'],
      \       ['true', 'false'],
      \       ['True', 'False'],
      \       ['on', 'off'],
      \       ['enable', 'disable'],
      \       ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      \       ['yes', 'no'],
      \       ['left', 'right'],
      \       ['=', ' = '],
      \       ['+', ' + '],
      \       ['-', ' - '],
      \       ['*', ' * '],
      \       ['/', ' / '],
      \       ['pick', 'squash', 'fixup', 'reword', 'edit'],
      \   ]},
      \   'toml vim': #{
      \     def: [[
      \       #{pattern: '"\([^"]*\)"'  , replace: '"\1"'},
      \       #{pattern: '''\([^'']*\)''', replace: '''\1'''},
      \   ]]},
      \}
" }}}
