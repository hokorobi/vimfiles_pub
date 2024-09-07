" hook_add {{{
" 開いているファイル、選択行を Github で開く
BulkMap nx <Space>oG <Cmd>Gina browse :<CR>
BulkMap nx <Space>go <Cmd>Gina browse :<CR>

nnoremap <Space>gbl <Cmd>Gina blame<CR>
nnoremap <Space>gg :Gina log -p -G""<Left>
" nnoremap <Space>gD <Cmd>Gina diff --opener=tabnew<CR>
" nnoremap <Space>gl <Cmd>Gina log --all --graph -100 --oneline<CR>
" nnoremap <Space>gL <Cmd>Gina log --all --patch --graph -100<CR>
" 指定したコミット、ブランチのバッファのファイルを表示。
" FIXME: これだと Gina の読み込みがされない。
" call AddLeft('nnoremap <Space>gbo :Gina compare --opener="tab vsplit" ', ':%')

call extend(g:vimrc_altercmd_dic, {
      \   'bro\%[wse]': 'Gina browse --exact :',
      \ })

let g:sayonara_filetypes['gina-blame'] = 'tabclose'
let g:sayonara_filetypes['gina-diff'] = 'tabclose'
let g:sayonara_filetypes['gina-log'] = 'bdelete'

call extend(g:vimrc_altercmd_dic, #{ gina: 'Gina', })
" }}}
" hook_source {{{
" alias
call gina#custom#command#alias('status', 'st')
call gina#custom#command#option('st', '-s')
" call gina#custom#command#option('status', '--opener', 'split')

call gina#custom#command#alias('branch', 'b')

call gina#custom#command#alias('log', 'gl')
call gina#custom#command#option('gl', '--graph')

" key mapping
call gina#custom#mapping#nmap('status', 'cc', ':<C-u>Gina commit -v --group=status<CR>', #{noremap: 1, silent: 1, buffer: 1, nowait: 1})
" show から戻るときは <C-o>
call gina#custom#mapping#nmap('blame', 's', ':<C-u>Gina show<CR>', #{noremap: 1, silent: 1, buffer: 1, nowait: 1})
call gina#custom#mapping#nmap('blame', 'e', '<Plug>(gina-blame-echo)', #{noremap: 0, buffer: 1, nowait: 1})
" copy revision
call gina#custom#mapping#nmap('log', 'yr', '<Plug>(gina-yank-rev)', #{noremap: 0, buffer: 1, nowait: 1})

" vim-jp 2021-03-12 obcat
" PR を作成するコマンド。一応書置き。
" command! -nargs=? PR Gina browse --scheme=pr <args>
" nnoremap <leader>aw :PR<CR>
" call extend(g:gina#command#browse#translation_patterns['github\.com'][1], #{pr: 'https://\1/\2/\3/pull/new/%c0'})
" }}}
