" hook_source {{{
let s:ddc_sourceOptions = {}
let s:ddc_sourceOptions['_'] = #{
    \   matchers: ['matcher_head'],
    \   sorters: ['sorter_rank'],
    \ }
let s:ddc_options = #{
    \   sourceOptions: s:ddc_sourceOptions,
    \   ui: 'pum',
    \ }
call ddc#custom#patch_global(s:ddc_options)

call ddc#custom#patch_filetype(
    \ ['vim'],
    \ #{sources: ['around']})
call ddc#enable()
" }}}
