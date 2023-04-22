" hook_add {{{
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:lightline = #{
      \   colorscheme: 'spring_night',
      \   active: #{
      \     left: [['mode', 'paste'], ['readonly', 'filename', 'modified', 'pwd']],
      \     right: [['lineinfo'], ['fileformat', 'fenc', 'filetype']]
      \   },
      \   mode_map: {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'V',
      \     'V' : 'VL',
      \     "\<C-v>": 'VB',
      \     'c' : 'C',
      \     's' : 'S',
      \     'S' : 'SL',
      \     "\<C-s>": 'SB',
      \     't': 'T',
      \   },
      \   component: #{
      \     lineinfo: ':%-2v',
      \   },
      \   component_function: #{
      \     swap: 'Swap',
      \     pwd: 'getcwd',
      \     fenc: 'LightlineFenc',
      \     filename: 'LightlineFilename',
      \     fileformat: 'LightlineFileformat',
      \     filetype: 'LightlineFiletype',
      \   },
      \   component_type: #{
      \     buffers: 'tabsel',
      \   },
      \ }

" https://github.com/thinca/config/blob/a8e3ee41236fcdbfcfa77c954014bc977bc6d1c6/dotfiles/dot.vim/vimrc#L378
function! Swap()
  return get(b:, 'swapfile_exists', 0) ? 'swp' : ''
endfunction

function! LightlineFilename() abort
  " quickfixリストを生成したコマンド or ディレクトリ名付き filename
  return &buftype ==# 'quickfix' ? get(w:, 'quickfix_title', '') : fnamemodify(bufname('%'), ':.')
endfunction

" BOM も表示する fenc
function! LightlineFenc() abort
  if winwidth(0) < 70
    return ''
  endif

  let fenc = &fileencoding == '' ? &encoding : &fileencoding
  return fenc !=# 'utf-8' ? fenc : &bomb ? fenc .. ' (BOM)' : fenc
endfunction

function! LightlineFiletype() abort
  return winwidth(0) < 70 ? '' : &filetype ==# '' ? 'no ft' : &filetype
endfunction

function! LightlineFileformat() abort
  return winwidth(0) < 70 ? '' : &fileformat
endfunction
" }}}
