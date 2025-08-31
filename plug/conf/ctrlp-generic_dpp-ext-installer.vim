" hook_add {{{
" リポジトリの更新
nnoremap <silent> <Space>du <Cmd>call dpp#get()
      \ ->keys()
      \ ->CtrlPGeneric('CtrlPGenericDppUpdate')<CR>

" リポジトリのディレクトリへ移動
nnoremap <Space>fc <Cmd>call dpp#get()
      \ ->map({_, v -> v.path})
      \ ->values()
      \ ->extend(dpp#check_clean())
      \ ->CtrlPGeneric('CtrlPGenericCd')<CR>

" リポジトリのディレクトリを選択して、その中のファイルを選択
nnoremap <Space>fr <Cmd>call dpp#get()
      \ ->map({_, v -> v.path})
      \ ->values()
      \ ->extend(dpp#check_clean())
      \ ->CtrlPGeneric('CtrlPGenericCtrlp')<CR>
" }}}
