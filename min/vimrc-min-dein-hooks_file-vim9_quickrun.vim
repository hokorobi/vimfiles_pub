" hook_source {{{
vim9script
g:quickrun_config = get(g:, 'quickrun_config', {})
g:quickrun_config._ = {
  'runner': 'job',
  'outputter': 'buffer',
  'outputter/buffer/close_on_empty': 1,
}
" }}}
