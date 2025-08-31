" hook_source {{{
" let g:empty_prompt#pattern = get(g:, 'empty_prompt#pattern', &shell =~# 'sh$' ? '\$ $' : '\S>\s*$')
" Use nyagos
" let g:empty_prompt#pattern = '\$ $'

" Enter command-line / normal-mode if current line is empty prompt
function s:empty_prompt_mappings() abort
  call empty_prompt#map(#{lhs: ';', rhs: "<C-w>:"})
  call empty_prompt#map(#{lhs: '<Esc>', rhs: "<C-w>N"})
endfunction
autocmd vimrc TerminalOpen * ++once call s:empty_prompt_mappings()
" }}}
