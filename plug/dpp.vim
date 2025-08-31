let s:dpp_home = expand('~/_vim/dein')
function InitPlugin(plugin)
  " Search from s:dpp_home directory
  let dir = $'{s:dpp_home}/repos/github.com/{a:plugin}'
  if !(isdirectory(dir))
    " Install plugin automatically.
    execute $'!git clone https://github.com/{a:plugin} {dir}'
  endif

  execute 'set runtimepath^=' .. fnamemodify(dir, ':p')->substitute('[/\\]$', '', '')
endfunction

" NOTE: dpp.vim path must be added
call InitPlugin('Shougo/dpp.vim')
call InitPlugin('Shougo/dpp-ext-lazy')

"---------------------------------------------------------------------------
" dpp configurations.
let g:dpp_basedir = expand('<script>:h')
const s:dpp_base = expand('~/_vim/dein')

if dpp#min#load_state(s:dpp_base)
  " NOTE: denops.vim and dpp plugins are must be added
  for s:plugin in [
        \   'Shougo/dpp-ext-installer',
        \   'Shougo/dpp-ext-toml',
        \   'Shougo/dpp-protocol-git',
        \   'vim-denops/denops.vim',
        \ ]
    call InitPlugin(s:plugin)
  endfor

  echohl WarningMsg | echomsg 'dpp load_state() is failed' | echohl NONE

  autocmd vimrc User DenopsReady call dpp#make_state(s:dpp_base, expand($'{g:dpp_basedir}/conf/dpp.ts'))
endif

autocmd vimrc User Dpp:makeStatePost echohl WarningMsg | echomsg 'dpp make_state() is done' | echohl NONE


function OpenUpdatePlugins() abort
  for lines in dpp#sync_ext_action('installer', 'getUpdateLogs')
    for line in split(lines, "\n")
      if match(line, 'https:\/\/github\.com\/\S\+') >= 0
        call lazy#MyOpenBrowser(trim(line))
      endif
    endfor
  endfor
endfunction

autocmd vimrc User Dpp:ext:installer:updateDone call OpenUpdatePlugins()

call extend(g:vimrc_altercmd_dic, #{
      \   dc: "call dpp#async_ext_action('installer', 'checkNotUpdated')",
      \   di: "call dpp#async_ext_action('installer', 'install')",
      \   du: "call dpp#async_ext_action('installer', 'update')",
      \   dr: $'call dpp#make_state("{substitute(s:dpp_base, "\\", "/", "g")}", "{expand(g:dpp_basedir .. "/conf/dpp.ts")->substitute("\\", "/", "g")}")',
      \ })
