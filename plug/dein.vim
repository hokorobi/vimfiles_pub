let s:dein_home = expand('~/_vim/dein')
let g:dein#install_log_filename = $'{s:dein_home}/dein.log'
let g:dein#install_github_api_token = get(g:, 'github_token', '')
execute $'set runtimepath& runtimepath+={s:dein_home}/repos/github.com/Shougo/dein.vim'
let g:dein#install_progress_type = 'floating'
let g:dein#auto_remote_plugins = v:false
" Strict check updated plugins yesterday
" let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#enable_hook_function_cache = v:true
" let g:dein#auto_recache = v:true

let s:tomls = [
      \   '~/vimfiles/plug/conf/_dein.toml',
      \   '~/vimfiles/plug/conf/_plugins.toml',
      \   '~/vimfiles/plug/conf/_denops.toml',
      \   '~/vimfiles/plug/conf/_ddu.toml',
      "\   '~/vimfiles/plug/conf/_ddc.toml',
      \   '~/vimfiles/plug/conf/_reference.toml',
      "\   '~/vimfiles/plug/conf/_asyncomplete.toml',
      \   '~/vimfiles/plug/conf/_vimcomplete.toml',
      \]
if dein#min#load_state(s:dein_home)
  call dein#begin(s:dein_home, s:tomls)
  for s:toml in s:tomls
    call dein#load_toml(s:toml)
  endfor
  call dein#end()
  call dein#save_state()
endif

call extend(g:vimrc_altercmd_dic, #{
      \   du: 'call dein#update()',
      \   dc: 'call dein#check_update(v:true)',
      \   di: 'call dein#install()',
      "\   dr: 'call dein#recache_runtimepath() | :q',
      \   dr: '!gvim -c "call dein\#recache_runtimepath() | :q"',
      \ })

autocmd vimrc VimEnter * call dein#call_hook('post_source')
