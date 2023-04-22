" hook_source {{{
call ddu#custom#patch_global(#{
    \   kindOptions: #{
    \     file: #{
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
    \   },
    \   sourceParams: #{
    \       file_external: #{
    \           cmd: ['git', 'log', '--all', '--graph', '-100', '--oneline']
    \       },
    \   },
    \   sources: [
    \     #{name: 'file_rec'},
    \     #{name: 'buffer'},
    \     #{name: 'file_external'},
    \     #{name: 'line'},
    \   ],
    \   ui: 'ff',
    \   uiParams: #{
    \     ff: #{
    \       autoResize: v:false,
    \       prompt: '>>> ',
    \       reversed: v:true,
    \       split: 'horizontal',
    \       startFilter: v:true,
    \       winHeight: '15',
    \     }
    \   },
    \ })
" }}}
