vim9script
scriptencoding utf-8

# Show cursor info / buffer info in popup
# https://github.com/kyoh86/dotfiles/blob/03ab2a71e691b4a9eee4f03f4693fd515e33afc9/vim/vimrc#L866-L896
export def Popup_cursor_info()
  const ro = &readonly ? 'RO' : ''
  const swap = get(b:, 'swapfile_exists', 0) ? 'swp' : ''
  const fname = &buftype ==# 'quickfix' ? get(w:, 'quickfix_title', '') : fnamemodify(bufname('%'), ':.')
  const modified = &modified ? '+' : ''
  const line2 = GenLine([modified, ro, swap, fname, getcwd()], ' | ')

  const ftype = &filetype ==# '' ? '' : &filetype
  # get cursor position informations
  const pos = getpos('.')
  # get charcode informations
  const char = strcharpart(strpart(getline('.'), col('.') - 1), 0, 1)
  const charnr = char2nr(char)
  # get encoding
  var fenc = &fileencoding == '' ? &encoding : &fileencoding
  fenc = fenc !=# 'utf-8' ? fenc : &bomb ? fenc .. ' (BOM)' : fenc

  const line3 = GenLine([&fileformat, fenc, ftype, pos[1] .. ':' .. pos[2]], ' | ')

  # カーソル位置のハイライト名を表示
  # https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
  const highlight =
    synstack(line('.'), col('.'))
    ->map((_, id) => synIDattr(id, 'name') == synIDtrans(id)->synIDattr('name')
          ? synIDattr(id, 'name')
          : printf('%s(%s)', synIDattr(id, 'name'), synIDtrans(id)->synIDattr('name')))
    ->join(' -> ')

  const vsep = '--------------------------------'

  # format output
  const lines = ['h ' .. highlight, vsep, line2, vsep, line3]
  # open temporary popup
  call popup_atcursor(lines, {
    border: [1, 1, 1, 1],
    pos: 'topleft',
    moved: 'any',
    padding: [0, 1, 0, 1],
    wrap: v:false,
    })
enddef
def GenLine(list: list<string>, sep: string): string
  var line = ''
  for s in list
    line = s ==# '' ? line : line .. s .. sep
  endfor
  return line[0 : -strlen(sep)]
enddef

# debug
# def で定義している関数を変更、追加した場合は一時的にコメントを外す。
# defcompile
