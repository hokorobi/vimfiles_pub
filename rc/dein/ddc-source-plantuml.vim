" hook_add {{{
let g:ddc_source_plantuml_cmd = 'C:/ols/Graphic/plantuml.jar'
" }}}
" hook_source {{{
call ddc#custom#patch_global(#{sourceOptions: #{plantuml: #{mark: 'U'}}})
call ddc#custom#patch_filetype(['plantuml'], #{sources: ['buffer', 'around', 'vsnip', 'plantuml', 'file']})
" }}}
