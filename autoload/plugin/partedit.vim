scriptencoding utf-8

function! plugin#partedit#operator_partedit() abort
  let context = context_filetype#get()
  if context.range == [[0, 0], [0, 0]]
    echohl WarningMsg
    echomsg '[partedit] Context is not found'
    echohl NONE
    return
  endif
  call partedit#start(context.range[0][0], context.range[1][0], #{filetype: context.filetype})
  nnoremap <buffer> qq <Cmd>ParteditEnd<CR>
endfunction
