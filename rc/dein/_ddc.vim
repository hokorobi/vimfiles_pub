vim9script
scriptencoding utf-8

dein#add('Shougo/ddc.vim', {
  depends: ['denops.vim', 'pum.vim'],
  on_event: ['InsertEnter'],
  hooks_file: '~/vimfiles/rc/dein/ddc.vim',
})

# hook_source だけだと遅延読込にならない？　lazy追加。
dein#add('Shougo/pum.vim', {
  lazy: 1,
  hooks_file: '~/vimfiles/rc/dein/pum.vim',
})

dein#add('Shougo/ddc-ui-pum', {
  on_source: 'ddc.vim',
})

dein#add('tani/ddc-fuzzy', {
  on_source: 'ddc.vim',
})

# dein#add('matsui54/ddc-matcher_fuzzy', {
#   on_source: 'ddc.vim',
# })

# dein#add('Shougo/ddc-matcher_head', {
#   on_source: 'ddc.vim',
# })

# dein#add('Shougo/ddc-sorter_rank', {
#   on_source: 'ddc.vim',
# })

dein#add('Shougo/neco-vim', {
  depends: 'ddc.vim',
  on_ft: ['vim'],
  hooks_file: '~/vimfiles/rc/dein/neco.vim',
})


dein#add('Shougo/ddc-source-around', {
  on_source: 'ddc.vim',
})


dein#add('matsui54/ddc-buffer', {
  # rev = '8698aa',
  on_source: 'ddc.vim',
})


dein#add('LumaKernel/ddc-source-file', {
  on_source: 'ddc.vim',
})


dein#add('shun/ddc-source-vim-lsp', {
  # rev = '257293',
  on_source: 'ddc.vim',
})


dein#add('hrsh7th/vim-vsnip', {
  lazy: 1,
  hooks_file: '~/vimfiles/rc/dein/vsnip.vim',
})


dein#add('hrsh7th/vim-vsnip-integ', {
  on_source: 'ddc.vim',
  depends: 'vim-vsnip',
})


dein#add('matsui54/denops-popup-preview.vim', {
  depends: 'denops.vim',
  # rev = 'b8f62b',
  on_source: 'ddc.vim',
  hooks_file: '~/vimfiles/rc/dein/denops-popup-preview.vim',
})


dein#add('Shougo/neco-syntax', {
  lazy: 1,
})


dein#add('hokorobi/ddc-source-neco-syntax', {
  on_ft: ['autohotkey'],
  frozen: 1,
  depends: ['neco-syntax', 'ddc.vim'],
  hooks_file: '~/vimfiles/rc/dein/ddc-source-neco-syntax.vim',
})


dein#add('hokorobi/ddc-source-plantuml', {
  on_ft: ['plantuml'],
  frozen: 1,
  depends: ['ddc.vim'],
  hooks_file: '~/vimfiles/rc/dein/ddc-source-plantuml.vim',
})

