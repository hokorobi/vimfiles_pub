let s:dpp_home = expand('~/_vim/dein')
function InitPlugin(plugin)
  " Search from ~/work directory
  let dir = expand('~/work/') .. fnamemodify(a:plugin, ':t')
  if !(isdirectory(dir))
    " Search from s:dpp_home directory
    let dir = s:dpp_home .. '/repos/github.com/' .. a:plugin
    if !(isdirectory(dir))
      " Install plugin automatically.
      execute '!git clone https://github.com/' .. a:plugin dir
    endif
  endif

  execute 'set runtimepath^=' .. fnamemodify(dir, ':p')->substitute('[/\\]$', '', '')
endfunction

" NOTE: dpp.vim path must be added
call InitPlugin('Shougo/dpp.vim')
call InitPlugin('Shougo/dpp-ext-lazy')


"---------------------------------------------------------------------------
" dpp configurations.
let $BASE_DIR = expand('<sfile>')->fnamemodify(':h')
const s:dpp_base = expand('~/_vim/dein')

if dpp#min#load_state(s:dpp_base)
  " NOTE: denops.vim and dpp plugins are must be added
  for s:plugin in [
        \   'Shougo/dpp-ext-installer',
        \   'Shougo/dpp-ext-local',
        \   'Shougo/dpp-ext-toml',
        \   'Shougo/dpp-protocol-git',
        \   'vim-denops/denops.vim',
        \ ]
    call InitPlugin(s:plugin)
  endfor

  echohl WarningMsg | echomsg 'dpp load_state() is failed' | echohl NONE

  " DenopsReady は不安定らしい。dpp.vim の対応で改善されているかも。あまり試していないけどmake_stateの実行はしてくれてた。
  " denops#server#wait_async() で書き換え？
  " https://zenn.dev/vim_jp/articles/0006-migrate_plugin_manager_to_dpp
  autocmd vimrc User DenopsReady call dpp#make_state(s:dpp_base, expand('$BASE_DIR/dpp.ts'))
  autocmd vimrc User Dpp:makeStatePost echohl WarningMsg | echomsg 'dpp make_state() is done' | echohl NONE
else
  autocmd vimrc BufWritePost *.vim,*.toml,vimrc,.vimrc call dpp#check_files()
endif
