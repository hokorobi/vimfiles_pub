" hook_add {{{
" FIXME: ClrzrOn と ClrzrRefresh を連続実行できるように
call extend(g:vimrc_altercmd_dic, {
      \   'colorh\%[ighlight]': 'ClrzrOn | ClrzrRefresh',
      \ })
" }}}
