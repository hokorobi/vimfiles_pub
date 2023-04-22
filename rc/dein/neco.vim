" hook_source {{{
call ddc#custom#patch_global(#{sourceOptions: #{necovim: #{mark: 'V'}}})
call ddc#custom#patch_filetype(['vim'], #{sources: ['necovim', 'buffer', 'around', 'file', 'vsnip']})
" }}}
