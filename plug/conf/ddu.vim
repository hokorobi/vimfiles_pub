" hook_add {{{
" preload
" call timer_start(1000, { _ -> LazyDdu() })
" function LazyDdu()
"   call ddu#load('files', 'ui', ['ff'])
"   call ddu#load('files', 'kind', ['file', 'word'])
"   call ddu#load('files', 'source', ['action', 'buffer', 'file_rec', 'git_log', 'git_branch', 'git_stash', 'help', 'output', 'line', 'quickfix_history', 'vim-bookmars', 'source', 'zenn_dev_article'])
" endfunction

call extend(g:vimrc_altercmd_dic, #{
  \ ddu: 'call ddu#start(#{sources: [#{name: ""}]})<Left><Left><Left><Left><Left>',
  \})
nnoremap <silent> <Space>gbB <Cmd>call ddu#start(#{sources: [#{name: 'git_branch'}]})<CR>
nnoremap <silent> <Space>gt <Cmd>call ddu#start(#{sources: [#{name: 'git_stash'}]})<CR>
nnoremap <silent> <Space>db <Cmd>call ddu#start(#{sources: [#{name: 'buffer'}]})<CR>
nnoremap <silent> <Space>df <Cmd>call ddu#start(#{sources: [#{name: 'file_rec'}]})<CR>
nnoremap <silent> <Space>dh <Cmd>call ddu#start(#{sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <Space>fh <Cmd>call ddu#start(#{sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <Space>dl <Cmd>call ddu#start(#{sources: [#{name: 'line'}]})<CR>
nnoremap <silent> <Space>dm <Cmd>call ddu#start(#{sources: [#{name: 'vim-bookmark'}]})<CR>
nnoremap <expr>   <Space>do printf(":call ddu#start(#{ sources: [#{name: 'output', params: #{command: '%s'}}]})\<Left>\<Left>\<Left>\<Left>\<Left>\<Left>", getreg(':'))
nnoremap <silent> <Space>dq <Cmd>call ddu#start(#{sources: [#{name: 'quickfix_history'}]})<CR>
nnoremap <silent> <Space>ds <Cmd>call ddu#start(#{sources: [#{name: 'source'}]})<CR>
if exists('g:zenn_path')
  nnoremap <silent> <Space>dz <Cmd>call ddu#start(#{sources: [#{name: 'zenn_dev_article'}]})<CR>
  nnoremap <silent> <Space>fz <Cmd>call ddu#start(#{sources: [#{name: 'zenn_dev_article'}]})<CR>
endif
" }}}
" hook_source {{{
call ddu#custom#patch_global(#{
    \   filterParams: #{
    \     converter_hl_dir: #{
    \       hlGroup: ['Directory', 'Label'],
    \     },
    \     matcher_kensaku: #{
    \       highlightMatched: 'Search',
    \     },
    \   },
    \   kindOptions: #{
    \     action: #{
    \       defaultAction: 'do',
    \     },
    \     bookmark: #{
    \       defaultAction: 'open',
    \     },
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \     git_branch: #{
    \       defaultAction: 'switch',
    \     },
    \     git_commit: #{
    \       defaultAction: 'showGin',
    \     },
    \     help: #{
    \       defaultAction: 'open',
    \     },
    \     quickfix_history: #{
    \       defaultAction: 'open',
    \     },
    \     source: #{
    \       defaultAction: 'execute',
    \     },
    \     word: #{
    \       defaultAction: 'append',
    \     },
    \     zenn_dev_article: #{
    \       defaultAction: 'open',
    \     },
    \   },
    \   sourceOptions: #{
    \     _: #{
    \       ignoreCase: v:true,
    \       matchers: [
    \         'matcher_substring'
    \       ],
    \     },
    \     file_rec: #{
    \       converters: ['converter_hl_dir'],
    \     },
    \     git_branch: #{
    \       columns: [
    \         'git_branch_head',
    \         'git_branch_name',
    \         'git_branch_date',
    \       ],
    \     },
    \     zenn_dev_article: #{
    \       path: g:zenn_path,
    \       columns: [
    \         'zenn_dev_title',
    \       ],
    \       sorters: [
    \         'sorter_mtime',
    \         'sorter_reversed',
    \       ],
    \       matchers: [
    \         'matcher_kensaku',
    \       ],
    \     },
    \   },
    \   ui: 'ff',
    \   uiParams: #{
    \     ff: #{
    \       autoResize: v:true,
    \       filterSplitDirection: 'botright',
    \       prompt: '> ',
    \       reversed: v:true,
    \       split: 'horizontal',
    \       winHeight: '15',
    \     }
    \   },
    \ })

" ddu 起動時に openFilterWindow を表示
" autocmd vimrc User Ddu:uiReady if &l:filetype ==# 'ddu-ff' | call ddu#ui#do_action('openFilterWindow') | endif

function s:ginShow(args) abort
  execute $'GinBuffer show {a:args.items[0].action.hash}'
  " Persist (UI を閉じない)
  return 4
endfunction
call ddu#custom#action('source', 'git_log', 'showGin', function('s:ginShow'))

function s:ginBrowse(args) abort
  execute $'GinBrowse {a:args.items[0].action.hash}'
  " Persist (UI を閉じない)
  return 4
endfunction
call ddu#custom#action('source', 'git_log', 'browseGin', function('s:ginBrowse'))

" }}}
" ddu-ff {{{
setlocal cursorline

" TODO: 選択したitemに対してactionを実行
" TODO: 選択したitemの色をわかりやすくする
nnoremap <buffer><silent>         <CR>      <Cmd>call ddu#ui#do_action('itemAction')<CR>
nnoremap <buffer><silent><nowait> <Esc>     <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent><nowait> <Space>   <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
nnoremap <buffer><silent>         <S-Space> <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
nnoremap <buffer><silent>         i         <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
nnoremap <buffer><silent><nowait> a         <Cmd>call ddu#ui#do_action('chooseAction')<CR>
nnoremap <buffer><silent>         p         <Cmd>call ddu#ui#do_action('togglePreview')<CR>
nnoremap <buffer><silent><nowait> q         <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer><silent><nowait> t         <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>

xnoremap <silent><buffer><nowait> <Space> :call ddu#ui#do_action('toggleSelectItem')<CR>
" }}}
" ddu-ff-filter {{{
" <CR> で itemAction にするか ddu-ff に戻るか便利な方を模索中。
inoremap <buffer><silent>       <CR>  <Esc><Cmd>call ddu#ui#do_action('itemAction')<CR>
inoremap <buffer><expr><silent> <Esc>
      \ col('.') > 1 ? "<Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>" :
      \ "<Esc><Cmd>call ddu#ui#do_action('quit')<CR>"
" inoremap <buffer><silent> <Esc> <Esc><Cmd>call ddu#ui#do_action('quit')<CR>
" inoremap <buffer><silent> <CR>  <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
" inoremap <buffer><silent> <Esc> <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
inoremap <buffer><silent> <C-j> <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>
inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>
inoremap <buffer><silent> <C-k> <Cmd>call ddu#ui#do_action('cursorNext')<CR>
inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorNext')<CR>

nnoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
nnoremap <buffer><silent> <Esc> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
" }}}
