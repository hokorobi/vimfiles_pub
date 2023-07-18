" hook_add {{{
" preload
call timer_start(10, { _ -> ddu#load('ui', ['ff']) })

nnoremap <silent> <Space>dw <Cmd>call ddu#start(#{sources: [#{name: 'window'}], uiParams: #{ff: #{autoAction: #{name: 'preview'}, previewFloating: v:true, previewHeight: 25, startAutoAction: v:true},},})<CR>
nnoremap <silent> <Space>fw <Cmd>call ddu#start(#{sources: [#{name: 'window'}], uiParams: #{ff: #{autoAction: #{name: 'preview'}, previewFloating: v:true, previewHeight: 25, startAutoAction: v:true},},})<CR>
nnoremap <silent> <Space>du <Cmd>call ddu#start(#{sources: [#{name: 'dein'}], kindOptions: #{file: #{defaultAction: 'update'},},})<CR>
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
    \     file: #{
    \       defaultAction: 'open',
    \     },
    \     help: #{
    \       defaultAction: 'open',
    \     },
    \     window: #{
    \       defaultAction: 'open',
    \     },
    \     word: #{
    \       defaultAction: 'append',
    \     },
    \   },
    \   sourceOptions: #{
    \     _: #{
    \       ignoreCase: v:true,
    \       matchers: ['matcher_substring'],
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
    \   sources: [
    \     #{name: 'buffer'},
    \     #{name: 'file_external'},
    \     #{name: 'file_rec'},
    \     #{name: 'help'},
    \     #{name: 'line'},
    \     #{name: 'window', params: #{format: 'tab\|%n:%w:%wn'}},
    \   ],
    \   ui: 'ff',
    \   uiParams: #{
    \     ff: #{
    \       autoResize: v:true,
    \       filterSplitDirection: 'botright',
    \       prompt: '>>> ',
    \       reversed: v:true,
    \       split: 'horizontal',
    \       startFilter: v:true,
    \       winHeight: '15',
    \     }
    \   },
    \ })
" }}}
