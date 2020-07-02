"==============================================================================
" Vim configuration
" Author:   hokorobi
" Platform: Windows
" Vim:      https://github.com/vim/vim-win32-installer/releases gVim
" CAUTION:  other platform, old version no compatibility
" REQUIRE:  mattn/files, xdoc2txt, pt (monochromegane/the_platinum_searcher),
"           jalan/pdftotext, golang/tools/goimports
"==============================================================================

scriptversion 3
set encoding=utf-8
scriptencoding utf-8

" vimrc 全体で使う augroup を初期化
augroup vimrc | autocmd! | augroup END

" vim-altercmd
" https://github.com/tyru/vim-altercmd
"   TODO: 再読み込みの場合も考慮する（？）

" https://github.com/DeaR/dotfiles/blob/7c021c276903d93e413bf0b4c7b134b1e0c8f946/.vimrc#L1421-L1436
"   dt:ウィンドウで表示しているバッファで diffthis
let g:vimrc_altercmd_dic = {
      \   'tagsg[en]': '!ctags -R',
      \   'dt': 'windo diffthis',
      \}

" vim-sayonara
" https://github.com/mhinz/vim-sayonara
let g:sayonara_filetypes = {}

" Cached executable
" https://github.com/DeaR/dotfiles/blob/7c021c276903d93e413bf0b4c7b134b1e0c8f946/.vimrc#L119-L126
let g:vimrc_executable = get(g:, 'vimrc_executable', {})
function! Vimrc_executable(expr)
  if !has_key(g:vimrc_executable, a:expr)
    let g:vimrc_executable[a:expr] = executable(a:expr)
  endif
  return g:vimrc_executable[a:expr]
endfunction


let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"


" Command {{{1

" エンコードを指定して開き直す
command! OpenUtf8 :e ++enc=utf-8
command! OpenSjis :e ++enc=cp932

" エンコードを変換
command! ToUtf8 :set fileencoding=utf-8
command! ToUtf8bom :set fileencoding=utf-8 bomb
command! ToSjis :set fileencoding=cp932

" 改行コード変換
command! ToDos :set fileformat=dos
command! ToCRLF :set fileformat=dos
command! ToUnix :set fileformat=unix
command! ToLF :set fileformat=unix

" / と :s///g をトグル
" 8.1.0271 あたりから :s でハイライトされるようになったけどまだ使ってる
" https://raw.githubusercontent.com/cohama/.vim/master/.vimrc
cnoremap <expr> <C-t> vimrc#ToggleSubstituteSearch(getcmdtype(), getcmdline())

" https://github.com/tyru/config/blob/01b2f0b73fb599995d642ebfb50096faf611fdb7/home/volt/rc/default/vimrc.vim
command! -nargs=* BulkMap call s:cmd_map(<q-args>)
function! s:cmd_map(args) abort
  let m = matchlist(a:args, '^\(.*\)\[\([nvxsoiclt]\+\)\]\(.*\)$')
  if empty(m)
    throw 'BulkMap: invalid arguments: ' . a:args
  endif
  let [l, modes, r] = m[1:3]
  let l = substitute(l, '<noremap>', '', 'g')
  let nore = l is# m[1] ? '' : 'nore'
  let l = trim(l, " \t")
  let r = trim(r, " \t")
  for m in split(modes, '\zs')
    let cmd = printf('%s%smap %s %s', m, nore, l, r)
    " echom cmd
    execute cmd
  endfor
endfunction

" My retab
" https://github.com/cohama/.vim/blob/master/.vimrc
command! -nargs=? Retab call vimrc#Retab(empty(<q-args>) ? &l:tabstop : <q-args>)

" インデントを簡単に設定
" https://github.com/cohama/.vim/blob/master/.vimrc
" ISetting    => 現在の状態を表示
" ISetting t4 => tab で幅4
" ISetting s2 => space で幅2
command! -nargs=? -bang ISetting call vimrc#ISetting(<q-args>, <bang>0)

" 今開いているファイルを削除
" https://github.com/cohama/.vim/blob/master/.vimrc
command! -bang -nargs=0 DeleteMe call vimrc#DeleteMe(<bang>0)

" 開いているファイルのディレクトリへ移動
" http://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
command! -nargs=? -complete=dir -bang CD call vimrc#ChangeCurrentDir('<args>', '<bang>')
nnoremap cd :<C-u>CD<CR>

" diff xdoc2txt
" xdoc2txt でフィルタリングした結果を diff
command! -nargs=0 DiffXdoc2txt call vimrc#DiffXdoc2txt()

" カーソル下の単語を vimgrep
command! -nargs=1 VimGrepCurrent vimgrep <args> %
nnoremap <expr> <Leader>* ':<C-u>VimGrepCurrent ' .. expand('<cword>') .. '<CR>'

" json processor
command! -nargs=? Jq call vimrc#Jq(<f-args>)
call extend(g:vimrc_altercmd_dic, {
      \ 'jj': 'Jq',
      \ 'jq': 'Jq',
      \ 'js[ontool]': 'Jq',
      \ })

" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
command! -nargs=? GrepWrap call vimrc#GrepWrap(<f-args>)
call extend(g:vimrc_altercmd_dic, {
      \ 'gw': 'GrepWrap',
      \ 'grepw[rap]': 'GrepWrap'})

" コマンドの結果をスクラッチバッファに表示
command! -bar ToScratch
      \ setlocal buftype=nofile bufhidden=delete noswapfile |
      \ nnoremap <buffer> qq :close<CR>
command! -nargs=1 -complete=command L
      \ <mods> new | ToScratch |
      \ call setline(1, split(execute(<q-args>), '\n'))
command! MessL :L messages
command! Map :L map
command! Nmap :L nmap
command! Vmap :L vmap
command! Xmap :L xmap
command! Smap :L smap
command! Tmap :L tmap
command! Omap :L omap
command! Imap :L imap
command! Lmap :L lmap
command! Cmap :L cmap
call extend(g:vimrc_altercmd_dic, {
      \   'scriptn[ames]': 'L scriptnames',
      \ })

" }}}1 Option {{{1

" Move {{{2
" カーソル移動を行頭、行末で止めない
set whichwrap=b,s,h,l,<,>,[,]

" 行移動時に可能ならば同列へ移動する
set nostartofline

" % で移動できるペアを追加
set matchpairs+=<:>,（:）,「:」,『:』,【:】

" }}}2 File {{{2

" viminfo のパスを指定
" ': oldfiles の数を増やす 100 -> 300
" n: viminfo ファイルのパスを指定。
set viminfo='300,<50,s10,h,rA:,rB:,n~/_vim/viminfo

" swapファイル他用ディレクトリ。カレントディレクトリは嫌
" 末尾 // でパスを考慮した一意なファイル名で書き込み。
set directory=$temp//
" swapファイルがあったらreadonlyで開く
autocmd vimrc SwapExists * let v:swapchoice = 'o'

" writebackup なので一時的にバックアップファイルは作成される
" 末尾 // でパスを考慮した一意なファイル名で書き込み。
set nobackup backupdir=$temp//

" 編集中でも他のファイルを開く
set hidden

" 改行コード LF
set fileformat=unix

" undo-persistence {{{
" undoファイルを保存するディレクトリの設定
let &undodir = expand('~/_vim/info/undo')
if !isdirectory(&undodir)
  silent! call mkdir(&undodir, 'p')
endif

set undofile
" }}}


" }}}2 Function {{{2

" クリップボードをOSと共有
" x なども共有されてしまうのでやめ
"set clipboard+=unnamed

" セッションにオプションとマッピングは保存しない
set sessionoptions-=options

" 日本語がチェックエラーになるのでスペルチェックを無効。設定で除外もできるけど
" スペルチェック自体不要なので。
set nospell

" 数値を八進数として解釈しない
" a, b, c ... の連番を使うこともあるので +alpha
set nrformats-=octal nrformats+=alpha

" 矩形選択で長さの足りない行はスペース扱い
set virtualedit=block

" : コマンドの履歴保持数など
set history=1000

" " をエスケープしない
" Hg ci -m "hoge fuga" の引数を "hoge fuga" そのままで渡したかっため
" 期待した効果は得られなかった
" set shellxescape-=\"

" }}}2 Look {{{2

" 相対行番号表示。set number と共に使うことで現在行を表示できる
set number relativenumber

" 長い行を表示
set display+=lastline

" カーソルを点滅させない
set guicursor+=a:blinkon0

" カーソルの上下に行を表示
set scrolloff=10

" +I 起動時のメッセージを非表示
" +c 補完関係のメッセージを表示しない
set shortmess+=I shortmess+=c

" 括弧入力時に対応する括弧を表示
set showmatch

" モードの表示をしない。lightline で表示しているため
set noshowmode

" 常にタブラインを非表示
set showtabline=0

" コマンド行の高さ
set cmdheight=2

" 長い行を折り返して表示
set wrap

" 常にステータス行を表示
set laststatus=2
" コマンドをステータス行に表示
set showcmd

" タイトルを表示
set title

" fold 無効化
" 折りたたみ時の右側に表示される文字 - を削除
set nofoldenable foldmethod=marker foldcolumn=3 fillchars=vert:\|

" 一行が折り返された場合、折り返した行の先頭に表示する文字
let &showbreak = '>_'

" マウス有効, 入力中にマウスカーソル非表示
set mouse=a mousehide

" 新規ウィンドウは下、右に開く
set splitbelow splitright
" ウィンドウ分割時にウィンドウの高さ、幅を変えない
set noequalalways

" メニュー非表示時に起動高速化
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

" +M $VIMRUNTIME/menu.vim を読み込まない
" -m メニューを非表示にする
" -t メニュー項目の切り離しを無効にする（よくわからん）
" -e gVimでもテキストベースのタブページを使う。 ap/vim-buftabline を使っていると guitablabel が空になるようなので。
" -T ツールバーを非表示
" +! 外部コマンドを端末ウィンドウで実行
set guioptions+=M guioptions-=m guioptions-=t guioptions-=e guioptions-=T guioptions+=!

set belloff=all

" パターンマッチに使うメモリを増やす
" rst で足りなくなった。
set maxmempattern=2000

" command-line window technique
" https://qiita.com/monaqa/items/e22e6f72308652fc81e2
" 行数を非表示
autocmd vimrc CmdwinEnter [:\/\?=] setlocal nonumber norelativenumber
" signcolumn を非表示
autocmd vimrc CmdwinEnter [:\/\?=] setlocal signcolumn=no

" タブ文字などを表示
set list listchars=eol:↲,tab:«-»,trail:_,extends:\

" }}}2 edit {{{2

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" +M マルチバイトの連結は空白なし
" -t 自動折返し止め
" -c 自動折返して、現在のコメント開始文字列を自動挿入はやめ
" +j コメントリーダーを除いて連結. v:version >= 704
set formatoptions+=M formatoptions-=t formatoptions-=c formatoptions+=j

" ファイル末尾に改行を追加しない
set nofixendofline

" insert mode で IME をオンにした状態から normal mode で r や R で IME をオフ
let s:lastiminsert = 0
autocmd vimrc InsertLeave * if v:insertmode !=# 'r' | let s:lastiminsert = &iminsert | set iminsert=0 | endif
autocmd vimrc InsertEnter * if v:insertmode ==# 'i' | let &iminsert = s:lastiminsert | endif

" }}}2 complete {{{2

" 補完メニューの高さ指定
set pumheight=10
" 候補の付加情報をプレビューウィンドウに表示しない -preview
" 候補がひとつのときもメニュー表示 +menuone
set completeopt-=preview completeopt+=menuone completeopt-=menu completeopt+=noinsert completeopt+=noselect
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" TODO: wildignore を設定する？　ついでに ctrlp custom ignore も？
" 参考: https://github.com/DeaR/dotfiles/blob/master/.vimrc

" }}}2 indent {{{2

" indent
" デフォルトの設定。ファイルタイプごとの設定は ftplugin にある
" 賢い indent
set cindent
" タブの画面上での幅
set tabstop=4
" キーボードで<Tab>キーを押した時に挿入される空白の量に tabstop の値を使う
set softtabstop=0
" タブをスペースに展開しない
set noexpandtab
" インデントの各段階に使われる空白の数
set shiftwidth=4
" 折り返された行を同じインデントで表示
set breakindent

" }}}2 search {{{2

" インクリメンタルサーチ, ハイライト
set incsearch hlsearch

" 検索時に大文字小文字を無視
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan

" タグファイル内検索は大文字小文字を区別する
set tagcase=match
" バッファファイルのあるディレクトリから親を辿って tags を探す
" http://thinca.hatenablog.com/entry/20090723/1248286959
set tags=./tags;


" }}}2 grep {{{2

" grep プログラムの指定

" rg は通常 SJIS の検索をしないのでやはり不便
" let &grepprg = 'rg --vimgrep --no-heading --sort path --no-ignore-vcs'
" set grepformat=%f:%l:%c:%m,%f:%l:%m
" /U: .gitignore を無視
let &grepprg = 'pt /nogroup /nocolor /column /hidden /home-ptignore /S /U'
" /column で桁を表示しているので %c も使うパターンを追加
set grepformat^=%f:%l:%c:%m

" grep 後に quickfix-window を表示
autocmd vimrc QuickFixCmdPost *grep* cwindow

" }}}2 others {{{2

" 印刷設定: 余白を狭く、シンタックスハイライトなし syntax:n、行番号あり number:y
set printoptions=left:2pc,right:3pc,top:3pc,bottom:2pc,syntax:n,number:y


" Swap
" https://github.com/thinca/config/blob/a8e3ee41236fcdbfcfa77c954014bc977bc6d1c6/dotfiles/dot.vim/vimrc#L651-L687
setglobal swapfile
autocmd vimrc SwapExists * call vimrc#on_SwapExists()
" swapfile からリカバリー
command! SwapfileRecovery call vimrc#swapfile_recovery()
" swapfile を削除
command! SwapfileDelete call vimrc#swapfile_delete()

" Improve diff
set diffopt& diffopt+=algorithm:histogram,indent-heuristic

" FIXME: temporary plugin {{{3
set packpath& packpath+=~/_vim
let s:jobs = {}
let s:plugdir = expand('~/_vim/pack/temp/opt')
function! s:gitclone_end(ch) abort
  let j = ch_getjob(a:ch)
  echomsg s:jobs[j] .. ' installed.'
endfunction

function! s:echo(_, msg) abort
  echo a:msg
endfunction

function! s:gitclone_temp(url) abort
  let cmd = printf('git clone --depth=1 %s', a:url)
  let j = job_start(['cmd', '-c', cmd], {
        \ 'out_cb': funcref('s:echo'),
        \ 'close_cb': funcref('s:gitclone_end'),
        \ })
  let s:jobs[j] = a:url
endfunction

command! -nargs=1 Templug call s:gitclone_temp(<f-args>)
" }}}3

" }}}2

" }}}1 Plugin {{{1

" ローカル設定の読み込み
let g:vimrc_local = '~/_vim/_vimrc.local'
if filereadable(expand(g:vimrc_local))
  execute 'source' .. g:vimrc_local
endif


" デフォルトプラグインの停止 {{{2
" http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
let g:loaded_gzip            = 1
let g:loaded_tar             = 1
let g:loaded_tarPlugin       = 1
let g:loaded_zip             = 1
let g:loaded_zipPlugin       = 1
let g:loaded_rrhelper        = 1
let g:loaded_2html_plugin    = 1
let g:loaded_vimball         = 1
let g:loaded_vimballPlugin   = 1
let g:loaded_getscript       = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logipat         = 1
" use matchup
let g:loaded_matchparen = 1
let g:loaded_matchit = 1

let g:skip_defaults_vim = 1

" netrw {{{3
" disable netrw.vim
" vim-protocol で代用
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" curl で HTTP301 などでも移動先を追跡するように
" これがないと github の raw が取得できなかった。
" let g:netrw_http_cmd='curl -k --post301 --post302 -L'
" let g:netrw_http_xcmd='-o'

" 静かに転送処理
" :e url の実行で curl がダウンロードした後にキーを押してコマンドプロンプトを閉じる必要がなくなる
" let g:netrw_silent=1

let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
" }}}3

" }}}2  changelog {{{2

let g:changelog_username=''
let g:changelog_dateformat='%Y-%m-%d (%a)'
let g:changelog_new_date_format="%d\n\n%c\n"
" changelog の syntax を適用させないように書いてみたけど駄目だった。
" タイミングがこれより前じゃないと駄目なんだろうな。
" autocmd vimrc Filetype changelog let b:current_syntax = 'changelog'

" }}}2  dein {{{2
let s:dein_home = expand('~/_vim/dein')
execute 'set runtimepath& runtimepath+=' .. s:dein_home .. '/repos/github.com/Shougo/dein.vim'
let g:dein#install_log_filename = s:dein_home .. '/dein.log'
let g:dein#auto_recache = 0

if dein#load_state(s:dein_home)
  call dein#begin(s:dein_home)
  call dein#load_toml(expand('~/vimfiles/rc/plugins.tml'))
  call dein#end()
  call dein#save_state()
endif

call extend(g:vimrc_altercmd_dic, {
      \ 'du': 'call dein#update()',
      \ 'di': 'call dein#install()',
      \ 'dl': 'view ' .. g:dein#install_log_filename,
      \ 'dr': 'call dein#recache_runtimepath()'})

autocmd vimrc VimEnter * call dein#call_hook('post_source')

filetype plugin indent on

" }}}2

" }}}1 Filetype {{{1

" バイナリファイルのテキスト化 {{{
" xlsx などが zip として表示されることを避ける
" https://vim.fandom.com/wiki/Open_PDF_files?oldid=16226
autocmd vimrc BufReadPost *.{doc,docx,pdf,ppt,pptx,xls,xlsx} setlocal readonly buftype=nofile noswapfile

" デフォルトプラグインの停止で設定済みになっているのでここでは不要
" let g:loaded_zipPlugin= 1

autocmd vimrc BufReadPost *.{doc,docx,ppt,pptx,xls,xlsx} %!xdoc2txt "%"

" PDF のテキスト表示は pdftotext を使用
" xdoc2txt で変換できないファイルも変換できたので。
" https://qiita.com/u1and0/items/526d95d6991bc19003d2
autocmd vimrc BufReadPost *.pdf %!pdftotext -layout -nopgbrk "%" -

" }}}

" PPx 用
autocmd vimrc Filetype cfg setlocal noexpandtab
autocmd vimrc BufNewFile,BufRead *.js9 set filetype=javascript

" }}}1 Key Mapping {{{1

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

" Space 単体は何もしない
nnoremap <Space> <Nop>

" toggle
nnoremap [toggle] <Nop>
nmap <Leader>t [toggle]

nnoremap <silent> [toggle]w :<C-u>call vimrc#toggle_option('wrap')<CR>
nnoremap <silent> <C-F3> :<C-u>call vimrc#toggle_option('wrap')<CR>

" ; と : の入れ替え
noremap ; :
noremap : ;

" 誤爆を防ぐ {{{
nnoremap <Leader>Q q
nnoremap q <Nop>
" IME のトグルに使っているのでノーマルモードで押し間違えることがあるため
nnoremap <C-^> <Nop>
" 保存せずに閉じるを無効へ
nnoremap ZQ <Nop>
" }}}

" ビジュアルモードローテーション
" ノーマルモードから v でビジュアルモード、さらに v で矩形ビジュアルモード、
" さらに v でノーマルモード
xnoremap v <C-v>

" Show cursor info / buffer info in popup
" https://github.com/kyoh86/dotfiles/blob/03ab2a71e691b4a9eee4f03f4693fd515e33afc9/vim/vimrc#L866-L896
nnoremap <silent> <C-CR> :<C-u>call vimrc#popup_cursor_info()<CR>

" Buffer {{{2

" 直前に閉じたファイルを開き直す
" 実際には、以前開いていたバッファを開く
noremap <C-z> <C-^>

" <C-s> でバッファ変更時のみ保存。無名はダイアログ表示
" http://d.hatena.ne.jp/tyru/20130803/cua_save
inoremap <script> <SID>(gui-save) <C-o><SID>(gui-save)
inoremap <silent> <script> <C-s> <SID>(gui-save)<ESC>
nnoremap <silent> <script> <C-s> <SID>(gui-save)
nnoremap <silent> <script> <Leader>w <SID>(gui-save)
nnoremap <SID>(gui-save) :<C-u>call <SID>gui_save()<CR>
function! s:gui_save()
  if bufname('%') ==# ''
    browse confirm saveas
  else
    update
  endif
endfunction

" :b でバッファリストを表示
cnoreabbrev <expr>b getcmdtype()==':' && getcmdline()=~'^b' ? 'ls<CR>:b' : 'b'

noremap <C-n> :<C-u>enew<CR>

" open vimrc
noremap <F4> :<C-u>edit $MYVIMRC<CR>
noremap <S-F4> :<C-u>edit ~/vimfiles/rc/plugins.tml<CR>

" Open cheatsheet
nnoremap <Leader>c :split<CR>:edit ~/vimfiles/rc/cheatsheet.rst<CR>

" バッファの切り替え
nnoremap b :bn<CR>
nnoremap B :bN<CR>

" http://stackoverflow.com/questions/15393301/automatically-sort-quickfix-entries-by-line-text-in-vim
" pt で grep を実行した後に結果をパス順にしたかったので sort
" QuickFixCmdPost で実行していたけど w:quickfix_title が常に setqflist() になってしまうのでやめ。
nnoremap <Leader>s :call vimrc#SortQuickfix('vimrc#QfStrCmp')<CR>

nnoremap qt :tabclose<CR>

" }}}2 Window {{{2

" Ctrl + hjkl でウィンドウ間を移動
noremap  <C-h> <C-w>h
noremap  <C-j> <C-w>j
noremap  <C-k> <C-w>k
noremap  <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

" ウィンドウを閉じる
noremap <C-q> :<C-u>close<CR>

" split and go
" 元ネタ http://daisuzu.hatenablog.com/entry/2012/08/19/235923
nnoremap <silent> _ :SplitAndGo split<CR>
nnoremap <silent> <bar> :SplitAndGo vsplit<CR>
command! -count=1 -nargs=1 SplitAndGo call vimrc#SplitAndGo(<q-args>)

" http://vim.g.hatena.ne.jp/ka-nacht/20090119/1232347709
nnoremap <silent> [toggle]q :<C-u>call vimrc#toggle_quickfix_window()<CR>

" コマンドラインウィンドウを開く
" cedit に <M-i> が設定できない？
cnoremap <M-i> <C-f>

" }}}2 Motion {{{2

" 表示上の行移動変更
" https://github.com/darookee/dotfiles/blob/2c11a0d322c04c549d13d9cacb282d1e44a5a3c7/vimrc#L195
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" スクロールしていくと最後一行になってしまうのを直す設定
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap! <M-j> <PageDown>
noremap <expr> <M-j> max([winheight(0) - 2, 1]) .. "\<C-d>" .. (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap! <M-k> <PageUp>
noremap <expr> <M-k> max([winheight(0) - 2, 1]) .. "\<C-u>" .. (line('.') < 1         + winheight(0) ? 'H' : 'L')

" mode nv は smarthome でマッピング
" smarthome は insert mode で動作するとき一度 normal mode に移行しているので自分の設定では IME がオフになってしまうから除外
BulkMap <noremap> [ci] <C-a> <Home>
BulkMap <noremap> [ci] <M-h> <Home>
BulkMap <noremap> [ci] <C-e> <End>
BulkMap <noremap> [ci] <M-l> <End>
onoremap <Leader>h ^
onoremap <Leader>l $


noremap! <C-n> <Down>
" noremap  <C-n> <Down>

noremap! <C-p> <Up>
noremap  <C-p> <Up>

cnoremap <C-f> <Right>
noremap  <C-f> l

noremap! <C-b> <Left>
noremap  <C-b> h

" 単語先頭へ進む w, 単語先頭へ戻る W
" dw で dW になるのでやめ
" noremap w W
" noremap W B

" タブ間移動
noremap <C-Tab> :<C-u>tabnext<CR>
noremap <C-S-Tab> :<C-u>tabprevious<CR>

" cn, cp
noremap <silent> <F10> :<C-u>call vimrc#listmove('next')<CR>
noremap <silent> <S-F10> :<C-u>call vimrc#listmove('previous')<CR>
noremap <silent> <F11> :<C-u>call vimrc#listmove('previous')<CR>

" http://postd.cc/how-to-boost-your-vim-productivity/
nnoremap <CR> G

" https://raw.githubusercontent.com/todashuta/.dotfiles/aa1f494c4f223113e619f2551161af2176df1deb/.vimrc#L693
" insert mode から戻るときにカーソルを移動させない
" その際 jumplist も更新しない
inoremap <silent> <Esc> <Esc>:keepjumps normal! `^<CR>

" 補完候補を Tab で選択
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'

" }}}2 Yank, Paste {{{2

" OS クリップボード {{{3
" 切り取り
xnoremap <Leader>d "+d

" 貼り付け
noremap! <C-v> <MiddleMouse>
nnoremap <C-v> "+gP

" コピー
BulkMap <noremap> [nx] <Leader>y "+y

" バッファのフルパス
nnoremap <silent><expr> <Leader>y% ':let @+ = "' .. substitute(expand("%:p"), "\\", "\\\\\\", "g") .. '"<CR>'

" バッファ全体
nnoremap <Leader>ye :<C-u>%y+<CR>

nnoremap <Leader>Y "+y$
"}}}3

nnoremap Y y$

" ペーストした内容を選択
" インデント以外に何か使い道あるのかな？
nnoremap <expr> gp '`['.strpart(getregtype(),0,1).'`]'

" }}}2 Edit {{{2
" lexima や neocomplete で C-h と BS を同じ挙動にする
map! <C-h> <BS>

" Del
noremap! <C-d> <Del>
noremap! <C-l> <Del>
snoremap <C-d> a<BS>
snoremap <C-l> a<BS>

" 行頭まで削除
inoremap <C-BS> <C-u>
nnoremap <C-BS> d0

" カーソル移動せずに改行挿入
nnoremap <M-o> :<C-U>call append(line('.'), repeat([''], v:count1))<CR>
nnoremap <M-O> :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>

" 日付入力
nnoremap <F6> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR><ESC>
inoremap <C-r><C-d> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <S-F6> [<C-R>=strftime("%Y-%m-%d")<CR>]!<SPACE>
nnoremap <S-F6> <ESC>i[<C-R>=strftime("%Y-%m-%d")<CR>]!<SPACE><ESC>

" smart indent when entering insert mode with i on empty lines
" https://github.com/yukiycino-dotfiles/dotfiles/blob/ff76abc26557f3158b10cf5bedc92767fad4877d/.vimrc#L246-L248
nnoremap <expr> i len(getline('.')) ? 'i' : 'cc'
nnoremap <expr> a len(getline('.')) ? 'a' : 'cc'
nnoremap <expr> A len(getline('.')) ? 'A' : 'cc'

" https://www.key-p.com/blog/staff/archives/104879
" コメント開始文字列を挿入せずに改行
inoremap <S-CR> <CR><C-u>
nnoremap <S-CR> o<C-u>

" visual repeat
" http://vim.wikia.com/wiki/Repeat_command_on_each_line_in_visual_block
vnoremap . :normal .<CR>

" Visual 選択状態でインデント後も選択状態のままにする
" https://twitter.com/mattn_jp/status/1202603537521401856
xnoremap < <gv
xnoremap <S-Tab> <gv
xnoremap > >gv
xnoremap <Tab> >gv

" @r に置換マクロ登録
let @r = ';%s/[^\\]*\./00001./ggnvveGg'

" 選択範囲を置換する
" http://qiita.com/itmammoth/items/312246b4b7688875d023
nnoremap <Leader># "zyiw:%s/\<<C-R>z\>/<C-R>z/gc<left><left>
" xnoremap <Leader># "zy:%s/\V<C-R>z/<C-R>z/g<left><left>
xnoremap <Leader># :call <SID>set_vsearch()<CR>:%s/<C-r>//<C-r>z/gc<Left><Left><Left>
function! s:set_vsearch()
  silent normal! gv"zy
  let @/ = '\V' .. substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction

" }}}2 Search {{{2

" clear hlsearch
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" incsearch 中に前後の候補へカーソル移動
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" 現在のバッファから grep
nnoremap <Leader>gr :<C-u>vimgrep // %<Left><Left><Left>

" }}}2

" }}}1 Git {{{1
call extend(g:vimrc_altercmd_dic, {'git': '!git'})

" Suppress git add -p message
let $LANG = 'ja_JP.UTF-8'

nnoremap <silent> <Leader>gl :!git gl -100<CR>
nnoremap <silent> <Leader>gd :!git diff<CR>
nnoremap <silent> <Leader>gs :!git status<CR>
" nnoremap <silent> <Leader>gbb :!git branch<CR>
nnoremap <Leader>gbb :call popup_atcursor(systemlist('git branch'), #{ moved: "any", border: [], minwidth: &columns/3, minheight: &lines/4 })<CR>
nnoremap <Leader>gp :!git push origin master

" コミット対象の hunk を選択する場合: ga -> gc
" コミットメッセージに詳細を書く場合: gu -> gc
nnoremap <silent> <Leader>ga :call popup_create(term_start(['git', 'add', '-p'], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: &columns*9/10, minheight: &lines/2 })<CR>
nnoremap <silent> <Leader>gu :silent !git add -u<CR>
nnoremap <silent> <Leader>gc :!git commit -v<CR>
" 単純なコミットメッセージの場合: gn
nnoremap <Leader>gn :!git commit -a -m ""<Left>

" 直前のコミットを master にする場合: gbr -> g-
" rename current branch
nnoremap <Leader>gbr :!git branch -m<Space>
" switch new branch (default: master) from last commit (default: master)
nnoremap <Leader>g- :!git switch -c master HEAD~<Left><Left><Left><Left><Left><Left>


" }}}1 Terminal {{{1
if has('terminal')
  " すでに :terminal が存在していればその :terminal を使用する
  " http://secret-garden.hatenablog.com/entry/2017/11/14/113127
  " FIXME: ウィンドウが開いていれば、そこにフォーカスしたい
  command! -nargs=* Terminal call vimrc#terminal_open(<q-args>)
  call extend(g:vimrc_altercmd_dic, {'ter[minal]': 'Terminal'})

  " 端末ウィンドウを複製する
  " http://tyru.hatenablog.com/entry/2018/09/23/021423
  tnoremap <C-w>y <C-w>:<C-u>call vimrc#dup_term_buf()<CR>
endif

" }}}1 GUI {{{1
if has('gui_running')
  " font {{{
  " set guifont=BDF_M+:h9
  " set guifont=Cica:h12:qANTIALIASED
  " set guifont=HackGen:h11:cSHIFTJIS:qDRAFT
  " set guifont=MyricaM_M:h11
  " set guifont=UD_デジタル_教科書体_N-R:h11
  " set guifont=Cica:h11
  set guifont=HackGenNerd_Console:h11:cSHIFTJIS:qDRAFT

  " 行間隔の設定
  set linespace=1

  " 一部のUCS文字の幅を2倍の幅とする
  set ambiwidth=double

  " Use colored emoji
  set renderoptions=type:directx,renmode:5,scrlines:1
  " }}}

  " 最大化で起動
  autocmd vimrc GUIEnter * simalt ~x

  " Make <M-Space> same as ordinal applications on MS Windows
  " https://github.com/tyru/config/blob/3e16b655e3dea14d55c4fbc6f41ec314e3480c5c/home/volt/rc/default/vimrc.vim#L581
  nnoremap <M-Space> :<C-u>simalt ~<CR>

  " colorscheme {{{
  " https://github.com/vim-jp/reading-vimrc/wiki/vimrcアンチパターン
  function! DefineMyHighlights()
    " IME の有効無効でカーソルの色を変更する。
    if has('multi_byte_ime')
      highlight CursorIM guifg=NONE guibg=Green gui=NONE
    endif
  endfunction
  autocmd vimrc ColorScheme * :call DefineMyHighlights()

  syntax on
  colorscheme spring-night
  " }}}

endif

" }}}

