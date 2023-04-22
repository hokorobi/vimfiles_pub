" ddu-ff {{{
setlocal cursorline

nnoremap <buffer><silent>         <CR>  <Cmd>call ddu#ui#do_action('itemAction')<CR>
nnoremap <buffer><silent><nowait> q     <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent><nowait> <Esc> <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent>         i     <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
" nnoremap <buffer><silent><nowait> <Space> <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
" }}}
" ddu-ff-filter {{{
" <CR> で itemAction にするか ddu-ff に戻るか便利な方を模索中。
inoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR><Cmd>call ddu#ui#do_action('itemAction')<CR>
inoremap <buffer><silent> <Esc> <Cmd>call ddu#ui#do_action('quit')<CR>
" inoremap <buffer><silent> <CR>  <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
" inoremap <buffer><silent> <Esc> <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
inoremap <buffer><silent> <C-j> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
inoremap <buffer><silent> <C-k> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>

nnoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
nnoremap <buffer><silent> <Esc> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
" }}}
