"==============================================================================
" Vim configuration
" Author:   hokorobi
" Platform: Windows
" Vim:      https://github.com/vim/vim-win32-installer/releases gVim
" CAUTION:  other platform, old version no compatibility
"==============================================================================

set encoding=utf-8
scriptencoding utf-8

" vimrc 全体で使う augroup を定義
augroup vimrc
  autocmd!
augroup END

" AlterCommand
" https://github.com/DeaR/dotfiles/blob/master/.vimrc
" TODO: 再読み込みの場合も考慮する（？）
let g:vimrc_altercmd_dic = {}

" Cached executable
" https://github.com/DeaR/dotfiles/blob/master/.vimrc
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
command! ToSjis :set fileencoding=cp932

" / と :s///g をトグル
" 8.1.0271 あたりから :s でハイライトされるようになったのでいらなくなったはず
" https://raw.githubusercontent.com/cohama/.vim/master/.vimrc
cnoremap <expr> <C-t> vimrc#ToggleSubstituteSearch(getcmdtype(), getcmdline())

" https://github.com/DeaR/dotfiles/blob/master/.vimrc
" Multi Mode Mapping: {{{
" map
command! -nargs=*
      \ NVmap
      \ nmap <args>| vmap <args>
command! -nargs=*
      \ NXmap
      \ nmap <args>| xmap <args>
command! -nargs=*
      \ NOmap
      \ nmap <args>| omap <args>
command! -nargs=*
      \ VOmap
      \ vmap <args>| omap <args>
command! -nargs=*
      \ XOmap
      \ xmap <args>| omap <args>
command! -nargs=*
      \ NXOmap
      \ nmap <args>| xmap <args>| omap <args>
command! -nargs=*
      \ NXImap
      \ nmap <args>| xmap <args>| imap <args>

" noremap
command! -nargs=*
      \ ICnoremap
      \ inoremap <args>| cnoremap <args>
command! -nargs=*
      \ NVnoremap
      \ nnoremap <args>| vnoremap <args>
command! -nargs=*
      \ NXnoremap
      \ nnoremap <args>| xnoremap <args>
command! -nargs=*
      \ NOnoremap
      \ nnoremap <args>| onoremap <args>
command! -nargs=*
      \ VOnoremap
      \ vnoremap <args>| onoremap <args>
command! -nargs=*
      \ XOnoremap
      \ xnoremap <args>| onoremap <args>
command! -nargs=*
      \ NXOnoremap
      \ nnoremap <args>| xnoremap <args>| onoremap <args>
"}}}

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
if Vimrc_executable('xdoc2txt')
  command! -nargs=0 DiffXdoc2txt call vimrc#DiffXdoc2txt()
endif

" ウィンドウで表示しているバッファで diffthis
call extend(g:vimrc_altercmd_dic, {'dt': 'windo diffthis'})

" カーソル下の単語を vimgrep
command! -nargs=1 VimGrepCurrent vimgrep <args> %
nnoremap <expr> <Leader>* ':<C-u>VimGrepCurrent ' . expand('<cword>') . '<CR>'

" jj
" http://qiita.com/tekkoc/items/324d736f68b0f27680b8
if Vimrc_executable('jj')
  command! -nargs=? Jj call vimrc#Jj(<f-args>)
  command! -nargs=? Jq call vimrc#Jj(<f-args>)
  call extend(g:vimrc_altercmd_dic, {'jj': 'Jj'})
elseif Vimrc_executable('jq')
  " jq
  command! -nargs=? Jq call vimrc#Jq(<f-args>)
  call extend(g:vimrc_altercmd_dic, {'jq': 'Jq'})
endif

" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
if Vimrc_executable('rg') || Vimrc_executable('pt')
  command! -nargs=? GrepWrap call vimrc#GrepWrap(<f-args>)
  call extend(g:vimrc_altercmd_dic, {
        \ 'gw': 'GrepWrap',
        \ 'grepw[rap]': 'GrepWrap'})
endif

" }}}1 Option {{{1

" kaoriya {{{2

"Kaoriya版に添付されているプラグインの無効化
if has('kaoriya')
  " https://sites.google.com/site/fudist/Home/vim-nihongo-ban/kaoriya-trouble#TOC-Kaoriya-
  "$VIM/plugins/kaoriya/autodate.vim
  let g:plugin_autodate_disable = 1
  "$VIM/plugins/kaoriya/plugin/cmdex.vim
  " :Tutorial を使うなら 0
  let g:plugin_cmdex_disable = 1
  "$VIM/plugins/kaoriya/plugin/dicwin.vim
  let g:plugin_dicwin_disable = 1
  "$VIMRUNTIME/plugin/format.vim
  let g:plugin_format_disable = 1
  "$VIM/plugins/kaoriya/plugin/hz_ja.vim
  let g:plugin_hz_ja_disable = 1
  "$VIM/plugins/kaoriya/plugin/scrnmode.vim
  let g:plugin_scrnmode_disable = 1
  "$VIM/plugins/kaoriya/plugin/verifyenc.vim
  let g:plugin_verifyenc_disable = 1
endif

" }}}2 Move {{{2
" カーソル移動を行頭、行末で止めない
set whichwrap=b,s,h,l,<,>,[,]

" 行移動時に可能ならば同列へ移動する
set nostartofline

" <> も % で移動
set matchpairs+=<:>

" }}}2 File {{{2

" viminfo のパスを指定
set viminfo+=n~/_vim/viminfo

" swapファイル他用ディレクトリ。カレントディレクトリは嫌
set directory=$temp
" swapファイルがあったらreadonlyで開く
autocmd vimrc SwapExists * let v:swapchoice = 'o'

" writebackup なので一時的にバックアップファイルは作成される
set nobackup backupdir=$temp

" 編集中でも他のファイルを開く
set hidden

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

" 常にタブラインを表示
set showtabline=2

" コマンド行の高さ
set cmdheight=2

" 長い行を折り返して表示
set wrap

" 常にステータス行を表示 (詳細は:he laststatus)
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
" -e gVimでもテキストベースのタブページを使う
" -T ツールバーを非表示
set guioptions+=M guioptions-=m guioptions-=t guioptions-=e guioptions-=T
" +! 外部コマンドを端末ウィンドウで実行 (8.0.1609)
if has('patch-8.0.1609')
  set guioptions+=!
endif

set belloff=all

" パターンマッチに使うメモリを増やす
" rst で足りなくなった。
set maxmempattern=2000

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

" grep プログラムに pt を指定
if Vimrc_executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --sort\ path
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif Vimrc_executable('pt')
  let &grepprg = 'pt /nogroup /nocolor /column /hidden /home-ptignore /S'
  " /column で桁を表示しているので %c も使うパターンを追加
  set grepformat^=%f:%l:%c:%m

  " http://stackoverflow.com/questions/15393301/automatically-sort-quickfix-entries-by-line-text-in-vim
  " pt で grep を実行した後に結果をパス順にしたかったので sort
  autocmd vimrc QuickFixCmdPost * call vimrc#SortQuickfix('vimrc#QfStrCmp')
endif

" grep 後に quickfix-window を表示
autocmd vimrc QuickFixCmdPost *grep* cwindow

" }}}2 others {{{2

" 印刷設定: 余白を狭く、シンタックスハイライトなし、行番号あり
set printoptions=left:2pc,right:3pc,top:3pc,bottom:2pc,syntax:n,number:y

" }}}2

" }}}1 Plugin {{{1

" ローカル設定の読み込み
let g:vimrc_local = '~/_vim/_vimrc.local'
if filereadable(expand(g:vimrc_local))
  execute 'source' . g:vimrc_local
endif


" デフォルトプラグインの停止
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

" netrw {{{
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
" }}}

"       sayonara {{{2
let g:sayonara_filetypes = {}

" }}}2  dein {{{2
let $DEIN_HOME = expand('~/_vim/dein')
set runtimepath+=$DEIN_HOME/repos/github.com/Shougo/dein.vim
let s:vimrcs = []
let s:toml = expand('~/vimfiles/rc/plugins.tml')
let s:candidate_toml = has('python3')
      \ ? expand('~/vimfiles/rc/denite.tml')
      \ : expand('~/vimfiles/rc/ctrlp.tml')
let s:candidate_both_toml = expand('~/vimfiles/rc/ctrlp_both.tml')
call extend(s:vimrcs, [
      \   s:toml,
      \   s:candidate_toml,
      \   s:candidate_both_toml,
      \   expand('~/vimfiles/vimrc'),
      \ ])
let g:dein#install_log_filename = $DEIN_HOME . '/dein.log'

if dein#load_state($DEIN_HOME)
  call dein#begin($DEIN_HOME, s:vimrcs)
  call dein#load_toml(s:toml)
  call dein#load_toml(s:candidate_toml)
  call dein#load_toml(s:candidate_both_toml)
  call dein#end()
  call dein#save_state()
endif

call extend(g:vimrc_altercmd_dic, {
      \ 'du': 'call dein#update()',
      \ 'di': 'call dein#install()',
      \ 'dl': 'view ' . g:dein#install_log_filename,
      \ 'dr': 'call dein#recache_runtimepath()'})

filetype plugin indent on

" }}}2  changelog {{{2

let g:changelog_username=''
let g:changelog_dateformat='%Y-%m-%d (%a)'
let g:changelog_new_date_format="%d\n\n%c\n"

" }}}2

" }}}1 Filetype {{{1

" Restore cursor position. {{{
autocmd vimrc BufReadPost * call s:restore_cursor_position()
function! s:restore_cursor_position()
  let ignore_filetypes = ['gitcommit', 'hgcommit', 'changelog', 'J6uil']
  if index(ignore_filetypes, &l:filetype) >= 0
    return
  endif

  if line("'\"") > 1 && line("'\"") <= line('$')
    execute 'normal! g`"'
  endif
endfunction
" }}}

" バイナリファイルのテキスト化 {{{
" https://vim.fandom.com/wiki/Open_PDF_files?oldid=16226
autocmd vimrc BufReadPost *.{doc,docx,pdf,ppt,pptx,xls,xlsx} setlocal readonly buftype=nofile noswapfile
if Vimrc_executable('xdoc2txt')
  " xlsx などが zip として表示されることを避ける

  " デフォルトプラグインの停止で設定済みになっているのでここでは不要
  " let g:loaded_zipPlugin= 1

  autocmd vimrc BufReadPost *.{doc,docx,ppt,pptx,xls,xlsx} %!xdoc2txt "%"
endif

" PDF のテキスト表示は pdftotext を使用
" xdoc2txt で変換できないファイルも変換できたので。
" https://qiita.com/u1and0/items/526d95d6991bc19003d2
if Vimrc_executable('pdftotext')
  autocmd vimrc BufReadPost *.pdf %!pdftotext -layout -nopgbrk "%" -
elseif Vimrc_executable('xdoc2txt')
  autocmd vimrc BufReadPost *.pdf %!xdoc2txt "%"
endif

" }}}

" PPx 用
autocmd vimrc Filetype cfg setlocal noexpandtab
autocmd vimrc BufNewFile,BufRead *.js9 set filetype=javascript

" diff バッファは最初から折り返す
if has('patch-8.1.397')
  autocmd vimrc DiffUpdated * if &diff | setlocal wrap | endif
else
  autocmd vimrc FilterWritePre * if &diff | setlocal wrap | endif
endif

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
nmap <Leader>t [toggle]
nnoremap [toggle] <Nop>

nnoremap <silent> [toggle]w :<C-u>call vimrc#toggle_option('wrap')<CR>
nnoremap <silent> <C-F3> :<C-u>call vimrc#toggle_option('wrap')<CR>

" ; と : の入れ替え
noremap ; :
noremap : ;

" 誤爆を防ぐ {{{
nnoremap Q q
nnoremap q <Nop>
nnoremap <Leader>Q q
" IME のトグルに使っているのでノーマルモードで押し間違えることがあるため
nnoremap <C-^> <Nop>
" 保存せずに閉じるを無効へ
nnoremap ZQ <Nop>
" }}}

" ビジュアルモードローテーション
" ノーマルモードから v でビジュアルモード、さらに v で矩形ビジュアルモード、
" さらに v でノーマルモード
vnoremap v <C-v>

" ペーストした内容を選択
" インデント以外に何か使い道あるのかな？
nnoremap <expr> gp '`['.strpart(getregtype(),0,1).'`]'

" カーソル位置のハイライト名を表示
" https://gist.github.com/thinca/9a0d8d1a91d0b5396ab15a632c34e03f
nmap <silent> <C-CR> <Plug>(vimrc-show-current-syntax)
nnoremap <silent> <Plug>(vimrc-show-current-syntax)
      \ :<C-u>echo join(map(synstack(line('.'), col('.')),'synIDattr(v:val, "name") . "(" . synIDattr(synIDtrans(v:val), "name") . ")"'), ',')<CR>

" マクロの登録
" @r に置換マクロ登録
let @r = ';%s/[^\\]*\./00001./ggnvveGg'


" Buffer {{{2

" 直前に閉じたファイルを開き直す
" 実際には、以前開いていたバッファを開く
noremap <C-z> <C-^>

" バッファ移動
noremap <silent> b :<C-u>bn<CR>
noremap <silent> B :<C-u>bp<CR>

" <C-s> でバッファ変更時のみ保存。無名はダイアログ表示
" http://d.hatena.ne.jp/tyru/20130803/cua_save
inoremap <script> <SID>(gui-save) <C-o><SID>(gui-save)
inoremap <silent> <script> <C-s> <SID>(gui-save)<ESC>
nnoremap <silent> <script> <C-s> <SID>(gui-save)
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

" 新規作成
noremap <C-n> :<C-u>enew<CR>

" vimrc 開く、読み込み
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
noremap <F4> :Ev<CR>
noremap <F5> :Rv<CR>

" Open cheatsheet
nnoremap <Leader>fc :split<CR>:edit ~/vimfiles/rc/cheatsheet.rst<CR>

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

" }}}2 Motion {{{2

" 表示上の行移動変更
" https://github.com/darookee/dotfiles/blob/2c11a0d322c04c549d13d9cacb282d1e44a5a3c7/vimrc#L195
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" カーソル移動 {{{
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap! <M-j> <PageDown>
noremap <expr> <M-j> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap! <M-k> <PageUp>
noremap <expr> <M-k> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')

onoremap <Leader>h ^
onoremap <Leader>l $

" mode nvi は smarthome でマッピング
cnoremap <C-a> <Home>
cnoremap <M-h> <Home>
cnoremap <C-e> <End>
cnoremap <M-l> <End>

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

" }}}

" don't use noremap because want to map to matchit plugin
NXOmap <Leader><Space> %

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

" }}}2 Yank {{{2

" クリップボードへコピー・切り取り・貼り付け
vnoremap <Leader>y "+y
vnoremap <C-c> "+y
vnoremap <C-x> "+d

noremap! <C-v> <MiddleMouse>
nnoremap <C-v> "+gP

" バッファのフルパスをクリップボードへコピー
nnoremap <silent><expr> <Leader>y% ':let @+ = "' . substitute(expand("%:p"), "\\", "\\\\\\", "g") . '"<CR>'

" バッファ全体をクリップボードへコピー
nnoremap <Leader>ye :<C-u>%y+<CR>

" keep cursor position when yanking in visual mode
" https://raw.githubusercontent.com/aoyama-val/dot/6d5143a2e62c28d60c775f0414ec00f51bee069f/etc/.vim/.vimrc
xnoremap <silent> y y`>


" highlightedyank で TextYankPost の有無で動きが違うので、それに併せて設定する
if exists('##TextYankPost')
  nmap Y y$

  nnoremap <silent> <Leader>yy :call <SID>Linecopy()<CR>
  function! s:Linecopy() abort
    let view = winsaveview()
    execute 'normal' "0vg_\"+y"
    silent call winrestview(view)
  endfunction
endif

" }}}2 Edit {{{2
" lexima や neocomplete で C-h と BS を同じ挙動にする
map! <C-h> <BS>

" Del
noremap! <C-d> <Del>

" 行頭まで削除
inoremap <C-BS> <C-u>
nnoremap <C-BS> d0

" カーソル移動せずに改行挿入
nnoremap <M-o> :<C-U>call append(line('.'), repeat([''], v:count1))<CR>
nnoremap <M-O> :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>

" 日付入力
nnoremap <F6> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR><ESC>
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <S-F6> [<C-R>=strftime("%Y-%m-%d")<CR>]!<SPACE>
nnoremap <S-F6> <ESC>i[<C-R>=strftime("%Y-%m-%d")<CR>]!<SPACE><ESC>

" smart indent when entering insert mode with i on empty lines
" http://qiita.com/Qureana/items/4790be39e04add101ee2
nnoremap <expr> i vimrc#IndentWithI()

" ハイライトしてから置換する
" http://qiita.com/itmammoth/items/312246b4b7688875d023
nnoremap # "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>:%s/<C-r>//<C-r>z/gc<Left><Left><Left>
xnoremap # mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z:%s/<C-r>//<C-r>z/gc<Left><Left><Left>
function! s:set_vsearch()
  silent normal! gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction

" https://www.key-p.com/blog/staff/archives/104879
" コメント開始文字列を挿入せずに改行
inoremap <S-CR> <CR><C-u>
nnoremap <S-CR> o<C-u>

" visual repeat
" http://vim.wikia.com/wiki/Repeat_command_on_each_line_in_visual_block
vnoremap . :normal .<CR>

" http://qiita.com/itmammoth/items/312246b4b7688875d023
" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" 選択範囲を置換
vnoremap <C-R> "hy:%s/\V<C-R>h//g<left><left>

" }}}2 Search {{{2

" インクリメンタルサーチで /, ? を簡単に検索できるようにする
" http://vim-jp.org/vim-users-jp/2009/10/22/Hack-91.html
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" clear hlsearch
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" incsearch 中に前後の候補へカーソル移動
cnoremap <C-j> <C-g>
cnoremap <C-k> <C-t>

" 選択範囲内を検索
vnoremap / <Esc>/\%V

" }}}2

" }}}1 Terminal {{{1
if has('terminal')
  tnoremap <Esc> <C-w><S-n>

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
  set guifont=Cica:h11
  " set guifont=MyricaM_M:h11

  " 行間隔の設定
  set linespace=1

  " 一部のUCS文字の幅を2倍の幅とする
  set ambiwidth=double

  " Use colored emoji
  if has('patch-8.0.1343')
    " renderoptions の設定のしかた — KaoriYa https://www.kaoriya.net/blog/2016/12/25/
    " 8.0.1390 から scrlines:1 でちょっと速くなるらしいので試しに
    set renderoptions=type:directx,renmode:5,scrlines:1
  endif
  " }}}

  " タブ文字などを表示
  set list listchars=eol:$,tab:»-,trail:_,extends:\

  " IMEの状態をいい感じにする
  if !has('patch-8.0.1114')
    set iminsert=0 imsearch=-1
  endif

  " 最大化で起動
  autocmd vimrc GUIEnter * simalt ~x

  " タブページを見やすく {{{
  " http://secret-garden.hatenablog.com/entry/2017/12/22/233144
  function! GuiTabLabel() abort
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " このタブページに変更のあるバッファがるときには '+' を追加する
    for bufnr in bufnrlist
      if getbufvar(bufnr, '&modified')
        let label = '+'
        break
      endif
    endfor

    " ウィンドウが複数あるときにはその数を追加する
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
      let label .= wincount
    endif
    if label !=# ''
      let label .= ' '
    endif

    " バッファ名を追加する
    return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  endfunction
  " グローバル関数でないとだめ
  set guitablabel=%{GuiTabLabel()}
  " }}}

  " colorscheme {{{
  " https://github.com/vim-jp/reading-vimrc/wiki/vimrcアンチパターン
  function! DefineMyHighlights()
    if g:colors_name is# 'hybrid'
      " 行番号が見づらかった。
      highlight LineNr ctermfg=14 guifg=#8d7571 guibg=#1d1f21
      " カーソル行もみやすく
      highlight CursorLine gui=underline guifg=NONE guibg=NONE
    endif

    " 選択行をみやすく
    highlight Visual guifg=Black guibg=#d33682 ctermbg=LightRed term=reverse
    " タブ文字を見やすく
    highlight SpecialKey guifg=#707880

    " IME の有効無効でカーソルの色を変更する。
    if has('multi_byte_ime')
      highlight CursorIM guifg=NONE guibg=Green gui=NONE
    endif
  endfunction
  autocmd vimrc ColorScheme * :call DefineMyHighlights()

  syntax on
  colorscheme iceberg
  " }}}

endif

" }}}

