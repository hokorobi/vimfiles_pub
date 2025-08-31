" hook_source {{{
for [key, value] in items(g:vimrc_altercmd_dic)
  call lexima_alter_command#add_rule(key, value)
endfor
" }}}
