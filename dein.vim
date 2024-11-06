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
      \   '~/vimfiles/rc/dein/_dein.toml',
      \   '~/vimfiles/rc/dein/_plugins.toml',
      \   '~/vimfiles/rc/dein/_denops.toml',
      \   '~/vimfiles/rc/dein/_ddu.toml',
      "\   '~/vimfiles/rc/dein/_ddc.toml',
      \   '~/vimfiles/rc/dein/_reference.toml',
      "\   '~/vimfiles/rc/dein/_asyncomplete.toml',
      \   '~/vimfiles/rc/dein/_vimcomplete.toml',
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
