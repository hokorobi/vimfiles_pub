" hook_add {{{
" hook_source だとうまく動かなかった

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/_vim/.log/vim-lsp.log')
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_float_delay = 200
let g:lsp_document_highlight_enabled = 0
" A> 非表示
let g:lsp_document_code_action_signs_enabled = 0
" Use denops-signature_help
let g:lsp_signature_help_enabled = 0
" do not use fold
let g:lsp_fold_enabled = 0

let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
" let lsp_diagnostics_virtual_text_align = 'right'
let g:lsp_diagnostics_virtual_text_padding_left = 2
let g:lsp_diagnostics_virtual_text_prefix = "🐛 "
" https://vim-jp.slack.com/archives/CQ57P4XU4/p1614523430139700
function! s:lsp_format() abort
  silent LspDocumentFormatSync
  LspCodeActionSync source.organizeImports
endfunction
function! s:on_lsp_buffer_enabled() abort
  if &l:buftype isnot# '' || win_gettype() isnot# ''
    return
  endif

  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  " keymap
  nnoremap <buffer> <Space>al <plug>(lsp-document-diagnostics)
  " 言語によっては LS が対応していない機能もあり、その場合は元の機能を使いたいので確実なものだけ設定。
  if &filetype is# 'go' || &filetype is# 'python'
    nnoremap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> gd <plug>(lsp-definition)
    nnoremap <buffer> <C-]> <plug>(lsp-definition)
    nnoremap <buffer> <Space>ar <plug>(lsp-rename)
    nnoremap <buffer> <Space>aR <plug>(lsp-references)
  endif

  " submode
  call submode#enter_with('lsp', 'n', 'br', '<Space>aj', '<plug>(lsp-next-diagnostic-nowrap)')
  call submode#enter_with('lsp', 'n', 'br', '<Space>an', '<plug>(lsp-next-diagnostic-nowrap)')
  call submode#enter_with('lsp', 'n', 'br', '<Space>ak', '<plug>(lsp-previous-diagnostic-nowrap)')
  call submode#enter_with('lsp', 'n', 'br', '<Space>ap', '<plug>(lsp-previous-diagnostic-nowrap)')
  call submode#map('lsp', 'n', 'brs', 'j', '<plug>(lsp-next-diagnostic-nowrap)')
  call submode#map('lsp', 'n', 'brs', 'n', '<plug>(lsp-next-diagnostic-nowrap)')
  call submode#map('lsp', 'n', 'brs', 'k', '<plug>(lsp-previous-diagnostic-nowrap)')
  call submode#map('lsp', 'n', 'brs', 'p', '<plug>(lsp-previous-diagnostic-nowrap)')

  if &filetype is# 'go'
    augroup vimrc-plugin-lsp-ft-go
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> call s:lsp_format()
    augroup END
  endif

  " For denops-signature_help
  call signature_help#enable()

endfunction
autocmd vimrc User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" }}}
