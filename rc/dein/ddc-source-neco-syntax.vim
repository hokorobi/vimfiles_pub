" hook_source {{{
call ddc#custom#patch_global(#{sourceOptions: #{necosyntax: #{mark: 'X'}}})
call ddc#custom#patch_filetype(['autohotkey'], #{sources: ['buffer', 'around', 'vsnip', 'necosyntax', 'file']})
" }}}
