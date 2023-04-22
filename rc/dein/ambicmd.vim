" hook_source {{{
"https://scrapbox.io/vim-jp/lexima%E3%81%A8ambicmd%E3%82%92cmdline%E3%81%A7%E4%BD%B5%E7%94%A8%E3%81%99%E3%82%8B
function! s:expand_command(key) abort
  let key2char = { "\<Space>": ' ', "\<CR>": "\r" }
  let key2lexima = { "\<Space>": '<Space>', "\<CR>": '<CR>' }

  let lexima = lexima#expand(key2lexima[a:key], ':')
  if lexima !=# key2char[a:key]
    return lexima
  endif

  let ambicmd = ambicmd#expand(a:key)
  if ambicmd !=# key2char[a:key]
    return ambicmd
  endif

  return a:key
endfunction

cnoremap <expr> <Space> <SID>expand_command("\<Space>")
cnoremap <expr> <CR>    <SID>expand_command("\<CR>")
" }}}
