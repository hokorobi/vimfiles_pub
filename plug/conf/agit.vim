" memo
" AgitGit! の ! は !git を実行。
" hook_add {{{
call extend(g:vimrc_altercmd_dic, {
      \ 'ag\%[it]': 'Agit',
      \ 'agf': 'AgitFile',
      \ })
nnoremap <silent> <Space>gl <Cmd>Agit<CR>
" }}}
" hook_source {{{
let g:agit_no_default_mappings = 1
" let g:sayonara_filetypes.agit = 'tabclose'
" let g:sayonara_filetypes.agit_stat = 'tabclose'
" let g:sayonara_filetypes.agit_diff = 'tabclose'
let g:agit_enable_auto_refresh = 1
let g:agit_max_author_name_width = 8
" }}}
" agit {{{
nnoremap <silent><buffer> u <PLug>(agit-reload)
" FIXME スクロールせずに何かプロセスが動いてる
nnoremap <silent><buffer> J <Plug>(agit-scrolldown-diff)
" FIXME スクロールせずに何かプロセスが動いてる
nnoremap <silent><buffer> K <Plug>(agit-scrollup-diff)
nnoremap <silent><buffer> s <Cmd>GinStatus<CR>
nnoremap <silent><buffer> a <Cmd>!git add --patch<CR>

nnoremap <silent><buffer> yc <Plug>(agit-yank-plus-commitmsg)
nnoremap <silent><buffer> yh <Plug>(agit-yank-plus-hash)
nnoremap <silent><buffer><nowait> q <Plug>(agit-exit)
nnoremap <silent><buffer><nowait> <CR> <Plug>(agit-show-commit)
" nnoremap <silent><buffer> <C-g> <Plug>(agit-print-commitmsg)

nnoremap <silent><buffer> C  <Plug>(agit-git-switch-detach)
nnoremap <silent><buffer> bb <Plug>(agit-git-checkout)
nnoremap <silent><buffer> cb <Plug>(agit-git-checkout-b)
nnoremap <silent><buffer> D  <Plug>(agit-git-branch-d)
nnoremap <silent><buffer> ch <Plug>(agit-git-cherry-pick)
nnoremap <silent><buffer> fi <Plug>(agit-git-fixup)
nnoremap <silent><buffer> rs <Plug>(agit-git-reset-soft)
nnoremap <silent><buffer> rm <Plug>(agit-git-reset)
nnoremap <silent><buffer> rh <Plug>(agit-git-restore-source)
nnoremap <silent><buffer> rb <Plug>(agit-git-rebase)
nnoremap <silent><buffer> ri <Plug>(agit-git-rebase-i)
nnoremap <silent><buffer> rv <Plug>(agit-git-revert)
nnoremap <silent><buffer> Bs <Plug>(agit-git-bisect-start)
nnoremap <silent><buffer> Bg <Plug>(agit-git-bisect-good)
nnoremap <silent><buffer> Bb <Plug>(agit-git-bisect-bad)
nnoremap <silent><buffer> Br <Plug>(agit-git-bisect-reset)

nnoremap <silent><buffer><nowait> t <Plug>(toggle-auto-show-commit)

let s:tips = [
      \   'u    再読み込み',
      \   'J/K  diffのスクロール 上/下',
      \   't    diffの自動表示トグル',
      \   's    GinStatus',
      \   'yc   コミットメッセージコピー',
      \   'yh   ハッシュ値コピー',
      \   '<CR> コミット表示',
      \   '',
      \   'C    コミットへスイッチ',
      \   'bb   ブランチへスイッチ',
      \   'cb   ブランチを作成してスイッチ',
      \   'D    ブランチ削除',
      \   'ch   cherry-pick',
      \   '',
      \   'rh   ワークツリーをコミットの内容に変更',
      \   'rs   コミットを取り消す。ワークツリーはそのまま',
      \   'rm   コミットとステージングを取り消す。ワークツリーはそのまま',
      \   '',
      \   'fi   fixup',
      \   'rb   rebase',
      \   'ri   rebase-i',
      \   '',
      \   'rv   revert',
      \   '',
      \   'Bs   bisect-start',
      \   'Bg   bisect-good',
      \   'Bb   bisect-bad',
      \   'Br   bisect-reset',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'agit')
nnoremap <buffer><silent> ? <Cmd>call cheatsheetecho#CheatSheetEcho(v:true)<CR>

" }}}
" agit-stat {{{
nnoremap <silent><buffer> u <PLug>(agit-reload)
nnoremap <silent><buffer> J <Plug>(agit-scrolldown-diff)
nnoremap <silent><buffer> K <Plug>(agit-scrollup-diff)
nnoremap <silent><buffer><nowait> q <Plug>(agit-exit)

nnoremap <silent><buffer> di <Plug>(agit-diff)
nnoremap <silent><buffer> dl <Plug>(agit-diff-with-local)

let s:tips = [
      \   'u  reload',
      \   'J  scrolldown-diff',
      \   'K  scrollup-diff',
      \   'di diff',
      \   'dl diff-with-local',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'agit-stat')
nnoremap <buffer><silent> ? <Cmd>call cheatsheetecho#CheatSheetEcho(v:true)<CR>
" }}}
" agit-diff {{{
nnoremap <silent><buffer> u <PLug>(agit-reload)
nnoremap <silent><buffer> J <Plug>(agit-scrolldown-stat)
nnoremap <silent><buffer> K <Plug>(agit-scrollup-stat)

nnoremap <silent><buffer><nowait> q <Plug>(agit-exit)

let s:tips = [
      \   'u reload',
      \   'J scrolldown-stat',
      \   'K scrollup-stat',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, 'agit-diff')
nnoremap <buffer><silent> ? <Cmd>call cheatsheetecho#CheatSheetEcho(v:true)<CR>
" }}}
