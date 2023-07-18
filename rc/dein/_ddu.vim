vim9script
scriptencoding utf-8

dein#add('Shougo/ddu.vim', {
  lazy: 1,
  on_func: 'ddu#',
  depends: 'denops.vim',
  hooks_file: '~/vimfiles/rc/dein/ddu.vim',
})

dein#add('Shougo/ddu-commands.vim', {
  depends: 'ddu.vim',
  on_cmd: 'Ddu',
  hooks_file: '~/vimfiles/rc/dein/ddu-commands.vim',
})

dein#add('Shougo/ddu-ui-ff', {
  on_source: 'ddu.vim',
  hooks_file: '~/vimfiles/rc/dein/ddu-ui-ff.vim',
})

dein#add('shun/ddu-source-buffer', {
  on_source: 'ddu.vim',
})

dein#add('matsui54/ddu-source-file_external', {
  on_source: 'ddu.vim',
})

dein#add('Shougo/ddu-source-file_rec', {
  on_source: 'ddu.vim',
})

dein#add('matsui54/ddu-source-help', {
  on_source: 'ddu.vim',
})

dein#add('Shougo/ddu-source-line', {
  on_source: 'ddu.vim',
})

# [[plugins]]
# dein#add('kuuote/ddu-source-mr', {
#   on_source: 'ddu.vim',
# })

dein#add('kamecha/ddu-source-window', {
  on_source: 'ddu.vim',
})

dein#add('Shougo/ddu-filter-matcher_substring', {
  on_source: 'ddu.vim',
})

dein#add('Shougo/ddu-kind-file', {
  on_source: 'ddu.vim',
})

dein#add('Shougo/ddu-kind-word', {
  on_source: 'ddu.vim',
})

# hlGroup にリスト指定で順番に色付けされるようになっていない
dein#add('kyoh86/ddu-filter-converter_hl_dir', {
  on_source: 'ddu.vim',
})
