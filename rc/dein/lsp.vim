" hook_add {{{
function s:lspSet() abort
  let lspOpts = #{
        \ autoComplete: v:false,
        \ condensedCompletionMenu: v:true,
        \}
  call LspOptionsSet(lspOpts)

  let lspServers = [
        \ #{name: 'deno',
        \   filetype: ['typescript'],
        \   path: 'deno',
        \   args: ['lsp'],
        \ },
        \ #{name: 'gopls',
        \   filetype: 'go',
        \   path: fnamemodify('~/_vim/lspservers/gopls/gopls.exe', ':p')->substitute('\', '/', 'g'),
        \   args: ['serve'],
        \   syncInit: v:true,
        \ },
        \ #{name: 'pylsp',
        \   filetype: 'python',
        \   path: 'pylsp',
        \   syncInit: v:true,
        \ },
        \ #{name: 'taplo',
        \   filetype: 'toml',
        \   path: 'taplo',
        \   args: ['lsp', 'stdio'],
        \ },
        \]
  call LspAddServer(lspServers)
endfunction
autocmd vimrc User LspSetup call s:lspSet()

function s:lspKeymap() abort
  nnoremap <buffer> <Space>al <Cmd>LspDiagShow<CR>
  nnoremap <buffer> K <Cmd>LspHover<CR>
  nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> <C-]> <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> <Space>ar <Cmd>LspRename<CR>
  nnoremap <buffer> <Space>aR <Cmd>LspReferences<CR>

  " submode
  call submode#enter_with('lsp', 'n', 'br', '<Space>aj', '<Cmd>LspDiagNext<CR>')
  call submode#enter_with('lsp', 'n', 'br', '<Space>an', '<Cmd>LspDiagNext<CR>')
  call submode#enter_with('lsp', 'n', 'br', '<Space>ak', '<Cmd>LspDiagPrev<CR>')
  call submode#enter_with('lsp', 'n', 'br', '<Space>ap', '<Cmd>LspDiagPrev<CR>')
  call submode#map('lsp', 'n', 'brs', 'j', '<Cmd>LspDiagNext<CR>')
  call submode#map('lsp', 'n', 'brs', 'n', '<Cmd>LspDiagNext<CR>')
  call submode#map('lsp', 'n', 'brs', 'k', '<Cmd>LspDiagPrev<CR>')
  call submode#map('lsp', 'n', 'brs', 'p', '<Cmd>LspDiagPrev<CR>')
endfunction
autocmd vimrc User LspAttached call s:lspKeymap()
" }}}
