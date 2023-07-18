" hook_add {{{
call extend(g:vimrc_altercmd_dic, {
  \ 'qr\%[un]': 'QuickRun',
  \ 'r\%[un]': 'QuickRun',
  \})
" }}}
" hook_source {{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \   'runner': 'job',
      \   'outputter': 'buffer',
      \   'outputter/buffer/close_on_empty': 1,
      \ }

let g:sayonara_filetypes.quickrun = 'bwipeout!'
" }}}
