" hook_add  {{{
let g:layout_path = '~/_vim/.layout/now.json'

call extend(g:vimrc_altercmd_dic, #{ss: 'call LayoutWrap()'})

nnoremap <Space>fs <Cmd>CtrlPLayout<CR>
command! -nargs=* CtrlPLayout call CtrlPGeneric(glob($'{fnamemodify(g:layout_path, ':p:h')}/*', v:true, v:true), 'LayoutCallback')

function LayoutWrap() abort
  let str = input('Filename: ', 'now')
  if len(str) == 0
    echo 'Stop LayoutWrap()'
    return 1
  endif
  call layout#save(printf('%s/%s.json', fnamemodify(g:layout_path, ':p:h'), str))
endfunction

function LayoutCallback(selected_value) abort
  call layout#load(a:selected_value)
endfunction
" }}}
