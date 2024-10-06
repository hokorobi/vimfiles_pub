" hook_add {{{
" preload
call timer_start(1000, { _ -> LazyDdu() })
function LazyDdu()
  call ddu#load('ui', ['ff'])
  call ddu#load('kind', ['file'])
endfunction

call extend(g:vimrc_altercmd_dic, #{
  \ ddu: 'call ddu#start(#{sources: [#{name: ""}]})<Left><Left><Left><Left><Left>',
  \})
nnoremap <silent> <Space>db <Cmd>call ddu#start(#{sources: [#{name: 'buffer'}]})<CR>
nnoremap <silent> <Space>df <Cmd>call ddu#start(#{sources: [#{name: 'file_rec'}]})<CR>
nnoremap <silent> <Space>dh <Cmd>call ddu#start(#{sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <Space>fh <Cmd>call ddu#start(#{sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <Space>du <Cmd>call ddu#start(#{sources: [#{name: 'dein'}]})<CR>
nnoremap <silent> <Space>dm <Cmd>call ddu#start(#{sources: [#{name: 'vim-bookmark'}]})<CR>
" zenn の記事をプレビューで確認できるようにしてみたけど、ディレクトリ内のファイルの title から検索できるようにしたいので PPx から peco を使った方が良さそう。
" サンプルとしてコメントで残しておく。
" nnoremap <silent> <Space>fz <Cmd>call ddu#start(#{sources: [#{name: 'file_rec', options: #{path: expand('~/Documents/zenn/articles')}}], uiParams: #{ff: #{autoAction: #{name: 'preview'}, previewFloating: v:true, previewHeight: 5, startAutoAction: v:true, startFilter: v:false},},})<CR>
" }}}
" hook_source {{{
call ddu#custom#alias('source', 'ls', 'file_external')
call ddu#custom#patch_global(#{
    \   filterParams: #{
    \     converter_hl_dir: #{
    \       hlGroup: ['Directory', 'Label'],
    \     },
    \   },
    \   kindOptions: #{
    \     action: #{
    \       defaultAction: 'do',
    \     },
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \     bookmark: #{
    \       defaultAction: 'open',
    \     },
    \     help: #{
    \       defaultAction: 'open',
    \     },
    \     word: #{
    \       defaultAction: 'append',
    \     },
    \   },
    \   sourceOptions: #{
    \     _: #{
    \       ignoreCase: v:true,
    \       matchers: [
    \         'matcher_substring'
    \       ],
    \     },
    \     dein: #{
    \       defaultAction: ['update'],
    \     },
    \     file_rec: #{
    \       converters: ['converter_hl_dir'],
    \     },
    \     file_external: #{
    \       converters: ['converter_hl_dir'],
    \     },
    \   },
    \   sourceParams: #{
    \       ls: #{
    \           cmd: ['git', 'ls-files']
    \       },
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

" }}}
" hook_post_update {{{
call ddu#set_static_import_path()
" }}}
