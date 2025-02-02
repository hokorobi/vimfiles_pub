vim9script
scriptencoding utf-8

# Show cursor info / buffer info in popup
# https://github.com/kyoh86/dotfiles/blob/03ab2a71e691b4a9eee4f03f4693fd515e33afc9/vim/vimrc#L866-L896
export def Popup_cursor_info()
  const ro = &readonly ? 'RO' : ''
  const swap = get(b:, 'swapfile_exists', 0) ? 'swp' : ''
  const fname = &buftype ==# 'quickfix' ? get(w:, 'quickfix_title', '') : fnamemodify(bufname('%'), ':.')
  const modified = &modified ? '+' : ''
  const line2 = GenLine([modified, ro, swap, fname, getcwd()])

  const ftype = &filetype ==# '' ? '' : &filetype
  # get cursor position informations
  const pos = getpos('.')
  # get encoding
  var fenc = &fileencoding == '' ? &encoding : &fileencoding
  fenc = &bomb ? $'{fenc} (BOM)' : fenc
  const line3 = GenLine([&fileformat, fenc, ftype, $'{pos[1]}:{pos[2]}'])

  # get charcode informations
  # const charcode = getline('.')->strpart(col('.') - 1)->strcharpart(0, 1)->char2nr()->printf('charcode: %d')

  # カーソル位置のハイライト名
  # https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
  const highlight =
    synstack(line('.'), col('.'))
    ->map((_, id) => synIDattr(id, 'name') == synIDtrans(id)->synIDattr('name')
          ? synIDattr(id, 'name')
          : printf('%s(%s)', synIDattr(id, 'name'), synIDtrans(id)->synIDattr('name')))
    ->join(' -> ')

  const vsep = '--------------------------------'

  [highlight, vsep, line2, vsep, line3]
  ->popup_atcursor({
    border: [1, 1, 1, 1],
    pos: 'topleft',
    moved: 'any',
    padding: [0, 1, 0, 1],
    wrap: v:false,
    })
enddef
def GenLine(list: list<string>): string
  return filter(list, 'v:val !=# ""')->join(' | ')
enddef

# カーソル下のハイライトの情報表示
# https://zenn.dev/vim_jp/articles/show-hlgroup-under-cursor
export def ShowHighlightGroup()
  var hlgroup = synIDattr(synID(line('.'), col('.'), 1), 'name')
  var groupChain: list<string> = []

  while hlgroup !=# ''
    groupChain->add(hlgroup)
    hlgroup = execute($'highlight {hlgroup}')->trim()->matchstr('\<links\s\+to\>\s\+\zs\w\+$')
  endwhile

  if empty(groupChain)
    echo 'No highlight groups'
    return
  endif

  for group in groupChain
    execute 'highlight' group
  endfor
enddef

# debug
# def で定義している関数を変更、追加した場合は一時的にコメントを外す。
# defcompile
