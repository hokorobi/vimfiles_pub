"======================================================================================
" Vim configuration
" Author   : hokorobi
" Platform : Windows
" Vim      : https://github.com/vim/vim-win32-installer/releases gVim
" CAUTION  : other platform, old version no compatibility. Reloading is not considered.
" REQUIRE  : xdoc2txt, pt (monochromegane/the_platinum_searcher), jalan/pdftotext,
"            golang/tools/goimports
"======================================================================================

scriptversion 3
set encoding=utf-8
scriptencoding utf-8

" vimrc 全体で使う augroup を初期化
"   thinca の教え
"   例えば BufEnter でバッファ用 autocmd 仕込むなら augroup がないと多重登録されることになる。
"   同様にあらゆる autocmd は doautocmd により複数回トリガーされる可能性がある。
"   なので私はバッファ用 autocmd にも常に augroup 付けてます。
augroup vimrc
  autocmd!
augroup END

" https://github.com/DeaR/dotfiles/blob/7c021c276903d93e413bf0b4c7b134b1e0c8f946/.vimrc#L1421-L1436
" Use lexima
let g:vimrc_altercmd_dic = {
     "\   ウィンドウに表示しているバッファで diffthis
      \   'dt': 'windo diffthis',
      \   'fmt': 'call lazy#Format()',
      \   'jj': 'call lazy#Format()',
      \   'jq': 'call lazy#Format()',
      \   'vn\%[map]': 'verbose nmap',
      \   'vc\%[map]': 'verbose cmap',
      \   'vi\%[map]': 'verbose imap',
      \   'vo\%[map]': 'verbose omap',
      \   'vv\%[map]': 'verbose vmap',
      \   'vx\%[map]': 'verbose xmap',
      \   'v\%[function]': 'verbose function',
     "\   https://zenn.dev/utubo/articles/20250820-run-vim9script-current-line
      \   'r9': 'vim9cmd source',
      \}

" vim-sayonara
" https://github.com/mhinz/vim-sayonara
let g:sayonara_filetypes = {}

" Cached executable
" https://github.com/DeaR/dotfiles/blob/7c021c276903d93e413bf0b4c7b134b1e0c8f946/.vimrc#L119-L126
let g:vimrc_executable = {}

" Command {{{1

" 文字コードを指定して開き直す
command! OpenUtf8 edit ++enc=utf-8
command! OpenSjis edit ++enc=cp932

" 文字コードを変換
command! ToUtf8 setlocal fileencoding=utf-8
command! ToUtf8bom setlocal fileencoding=utf-8 bomb
command! ToSjis setlocal fileencoding=cp932

" 改行コード変換
command! ToDos setlocal fileformat=dos
command! ToCRLF setlocal fileformat=dos
command! ToUnix setlocal fileformat=unix
command! ToLF setlocal fileformat=unix

" https://zenn.dev/kawarimidoll/articles/513d603681ece9
def s:bulkmap(modes: string, ...args: list<string>)
  const arg = join(args, ' ')
  for mode in split(modes, '.\zs')
    if index(split('nvsxoilct', '.\zs'), mode) < 0
      echoerr $'Invalid mode is detected: {mode}'
      continue
    endif
    execute $'{mode}noremap {arg}'
  endfor
enddef
command! -nargs=+ BulkMap call s:bulkmap(<f-args>)

" インデントを簡単に設定
command! -complete=customlist,lazy#ISettingCompl -nargs=? -bang ISetting call lazy#ISetting(<f-args>)

" 今開いているファイルを削除
" https://github.com/cohama/.vim/blob/master/.vimrc
command! -bang -nargs=0 DeleteMe call lazy#DeleteMe(<bang>0)

" 開いているファイルのディレクトリへ移動
" http://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
command! -nargs=? -complete=dir -bang CD call lazy#ChangeCurrentDir('<args>', '<bang>')
nnoremap cd <Cmd>CD<CR>

" diff xdoc2txt
" xdoc2txt でフィルタリングした結果を diff
command! -nargs=0 DiffXdoc2txt call lazy#DiffXdoc2txt()

" カーソル下の単語を vimgrep
" command! -nargs=1 VimGrepCurrent vimgrep <args> %
" nnoremap <expr> <Space>* '<Cmd>VimGrepCurrent ' .. expand('<cword>') .. '<CR>'

" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
command! -nargs=? GrepWrap call lazy#GrepWrap(<f-args>)
call extend(g:vimrc_altercmd_dic, {
      \ 'gw': 'GrepWrap',
      \ 'grepw\%[rap]': 'GrepWrap',
      \ })

" https://github.com/ukiuki-engineer/nvim/blob/f718eb30515f1f4afce172cc9cf9dd25a9648442/lua/config/lazy/commands.lua#L13-L14
" バッファのフルパスをヤンクする
command! YankBufFullPath :let @0 = expand('%:p') | :let @+ = expand('%:p')
" バッファのファイル名をヤンクする
command! YankBufFileName :let @0 = expand('%:t') | :let @+ = expand('%:t')

" コマンドラインモードのカーソル位置を左に移動
function AddLeft(lhs, rhs, add = 0)
  return printf('%s%s%s', a:lhs, a:rhs, repeat('<Left>', len(a:rhs) + a:add))
endfunction

" }}}1 Option {{{1

" move {{{2
" カーソル移動を行頭、行末で止めない
set whichwrap=b,s,h,l,<,>,[,]

" 行移動時に可能ならば同列へ移動する
set nostartofline

" % で移動できるペアを追加
set matchpairs+=<:>,（:）,「:」,『:』,【:】

" }}}2 file {{{2

" viminfo のパスを指定
" n: viminfo ファイルのパスを指定。
set viminfo='100,<50,s10,h,rA:,rB:,n~/_vim/viminfo

" swapファイル他用ディレクトリ。カレントディレクトリは嫌
" 末尾 // でパスを考慮した一意なファイル名で書き込み。
set directory=$temp//
" swapファイルがあったらreadonlyで開く
" Recover.vim
" autocmd vimrc SwapExists * let v:swapchoice = 'o'

" nobackup でも writebackup なので一時的にバックアップファイルは作成される
" 末尾 // でパスを考慮した一意なファイル名で書き込み。
set nobackup backupdir=$temp//

" 未保存でも他のファイルを開く
set hidden

" 新規バッファの改行コードを LF にする
set fileformats=unix,dos

" undoファイルを保存するディレクトリの設定
let &undodir = expand('~/_vim/info/undo')
if !isdirectory(&undodir)
  silent! call mkdir(&undodir, 'p')
endif
set undofile

" }}}2 function {{{2

" セッションにオプションとマッピングは保存しない
set sessionoptions-=options

" 日本語がチェックエラーになるのでスペルチェックを無効。
" 設定で除外もできるけどスペルチェック自体不要なので。
set nospell

" -octal 数値を八進数として解釈しない
" +alpha a, b, c ... の連番を使うこともあるので
" +unsigned 数字を符号なしで扱う
set nrformats-=octal nrformats+=alpha nrformats+=unsigned

" 矩形選択で長さの足りない行はスペース扱い
set virtualedit=block

" コマンドの履歴保持数などを拡張
set history=1000

" }}}2 look {{{2

" 現在行と相対行番号表示
set number relativenumber

" 長い行を表示
set display+=lastline

" カーソルを点滅させない
set guicursor+=a:blinkon0

" カーソルの上下に行を表示
set scrolloff=10

" +I 起動時のメッセージを非表示
" +c 補完関係のメッセージを非表示
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

" マウスはノーマルモードだけで有効化, 入力中にマウスカーソル非表示
" https://github.com/KentoOgata/dotfiles/blob/06f146495dbbe347f1d6439f7dd77516dc5c1e63/dot_config/nvim/options.vim#L16
set mouse=n mousehide

" 新規ウィンドウは下、右に開く
set splitbelow splitright
" ウィンドウ分割時にウィンドウの高さ、幅を等幅にする
set equalalways

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
set list listchars=tab:«-»,trail:_,extends:»,precedes:«,nbsp:%

" https://mattn.kaoriya.net/software/vim/20070821175457.htm
" シンタックスハイライトの閾値を拡張
autocmd vimrc Syntax * syntax sync minlines=500 maxlines=1000

" 大きなファイルをすぐ開く
" https://vim-jp.slack.com/archives/C03C4RC9F/p1652842090652059
" https://vim-jp.slack.com/archives/C03C4RC9F/p1652842245469699
" BufReadPost だと <C-s> で保存できなくなるので BufEnter へ
autocmd vimrc BufEnter * if getfsize(@%) > 1024 * 1024 * 2 | setlocal syntax=OFF | setlocal eventignorewin=all | call interrupt() | endif

" tabpanel setting {{{3
" https://zenn.dev/utubo/articles/20250526-show-hiddens-in-tabpanel
set showtabpanel=2
set tabpanel=%!vimrc#TabPanel()
augroup showbuffers_in_tabpanel
  autocmd!
  autocmd BufDelete * autocmd SafeState * ++once redrawtabp
augroup END
" }}}3

" }}}2 edit {{{2

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" ファイル末尾に改行を追加しない
set nofixendofline

" insert mode で IME をオンにした状態のまま normal mode に戻って R では IME をオフ
" 再度 insert mode に戻ったら IME オン
"   InsertLeave でなく ModeChanged なら C-c でインサートモードを抜けた時にも動作が有効になる
let s:lastiminsert = 0
autocmd vimrc ModeChanged i*:* let s:lastiminsert = &iminsert | setlocal iminsert=0
autocmd vimrc ModeChanged R*:* setlocal iminsert=0
autocmd vimrc ModeChanged *:i* let &l:iminsert = s:lastiminsert

" }}}2 complete {{{2

" 補完メニューの高さ指定
set pumheight=10
" 候補の付加情報をプレビューウィンドウに表示しない -preview
" 候補がひとつのときもメニュー表示 +menuone
set completeopt-=preview completeopt+=menuone
" TODO: 配列で書いて join する？ 参考: https://github.com/DeaR/dotfiles/blob/master/.vimrc
set wildignore=.git,.hg,.bzr,.svn,*.264,*.7z,*.aac,*.ac3,*.ape,*.arj,*.asf,*.asx,*.avi,*.avif,*.bmp,*.bz2,*.cab,*.chm,*.com,*.dll,*.doc,*.docx,*.emf,*.exe,*.flac,*.flv,*.fon,*.gca,*.gif,*.gz,*.hlp,*.ish,*.jar,*.jpe,*.jpeg,*.jpg,*.lnk,*.lzh,*.m1v,*.m4a,*.m4b,*.mid,*.mkv,*.mov,*.mp3,*.mp4,*.mpeg,*.mpg,*.msi,*.msu,*.ods,*.odt,*.ogg,*.ogm,*.opus,*.pdf,*.png,*.ppt,*.pptx,*.pyc,*.pyd,*.pyo,*.ram,*.rar,*.rm,*.rmvb,*.svg,*.swf,*.tak,*.tbz,*.tgz,*.tif,*.torrent,*.tta,*.wav,*.webm,*.webp,*.wma,*.wmv,*.wsf,*.wv,*.wvc,*.xls,*.xlsm,*.xlsx,*.xltm,*.xltx,*.xz,*.zip,*.zoo,*.o,*.obj,*.lib,*.so,*.swp,tags

" コマンドライン補完
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
set wildoptions=fuzzy,pum
autocmd CmdlineChanged [:\/\?] call wildtrigger()
set wildmode=noselect:lastused,full

" }}}2 indent {{{2

" indent
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
" x バッファファイルのあるディレクトリから親を辿って tags を探す
" x http://thinca.hatenablog.com/entry/20090723/1248286959
" ネットワークファイルを開いたときに遅くなっている気がするので無効にする。
" set tags=./tags;

" }}}2 grep {{{2

" grep プログラムの指定

" rg は通常 SJIS の検索をしないのでやはり不便
" let &grepprg = 'rg --vimgrep --no-heading --sort path --no-ignore-vcs'
" set grepformat=%f:%l:%c:%m,%f:%l:%m

" /U: .gitignore を無視
let &grepprg = 'pt /nogroup /nocolor /column /hidden /home-ptignore /S /U'
" /column で桁を表示しているので %c も使うパターンを追加
set grepformat^=%f:%l:%c:%m

" auto quickfix opener
" https://github.com/monaqa/dotfiles/blob/424b0ab2d7623005f4b79544570b0f07a76e921a/.config/nvim/scripts/autocmd.vim#L100-L104
autocmd vimrc QuickfixCmdPost [^l]* cwindow
autocmd vimrc QuickfixCmdPost l* lwindow

" }}}2 others {{{2

" 印刷設定: 余白を狭く、シンタックスハイライトなし syntax:n、行番号あり number:y
set printoptions=left:2pc,right:3pc,top:3pc,bottom:2pc,syntax:n,number:y

setglobal swapfile

" Improve diff
set diffopt& diffopt+=algorithm:histogram,closeoff,filler,followwrap,indent-heuristic,linematch:60,vertical

" ja の後に en を探しに行く
set helplang=ja,en

" 前に使ったウィンドウにジャンプ
set switchbuf=uselast

" }}}2

" }}}1 Plugin {{{1

" ローカル設定の読み込み
let g:vimrc_local = '~/_vim/_vimrc.local'
if filereadable(expand(g:vimrc_local))
  execute $'source {g:vimrc_local}'
endif

packadd hlyank

" デフォルトプラグインの停止 {{{2
" http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
let g:loaded_2html_plugin     = 1
let g:loaded_getscriptPlugin  = 1
let g:loaded_gzip             = 1
let g:loaded_logiPat          = 1
let g:loaded_rrhelper         = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tar              = 1
let g:loaded_tarPlugin        = 1
let g:loaded_vimball          = 1
let g:loaded_vimballPlugin    = 1
let g:loaded_zip              = 1
let g:loaded_zipPlugin        = 1

let g:skip_defaults_vim = 1

" netrw {{{3
" disable netrw.vim
" vim-protocol で代用
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" 静かに転送処理
" :e url の実行で curl がダウンロードした後にキーを押してコマンドプロンプトを閉じる必要がなくなる
" let g:netrw_silent=1

" }}}3

" }}}2  changelog {{{2

let g:changelog_username = ''
let g:changelog_dateformat = '%Y-%m-%d (%a)'
let g:changelog_new_date_format = "%d\n\n%c\n"

" }}}2  dein/dpp {{{2
" execute $'source {expand('<script>:h')}/plug/dein.vim'
execute $'source {expand('<script>:h')}/plug/dpp.vim'
" }}}2

filetype plugin indent on

" }}}1 Filetype {{{1

" yaml
" https://vim-jp.slack.com/archives/C03C4RC9F/p1705032728233209 @Ken Takata
" # でインデントしないように。
autocmd vimrc FileType yaml setlocal indentkeys-=0#

" バイナリファイルのテキスト化 {{{
" xlsx などが zip として表示されることを避ける
" https://vim.fandom.com/wiki/Open_PDF_files?oldid=16226
autocmd vimrc BufReadPost *.{doc,docx,pdf,ppt,pptx,xls,xlsx} setlocal readonly buftype=nofile noswapfile

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

" :help map-table

" Space 単体は何もしない
nnoremap <Space> <Nop>

" toggle
nnoremap [toggle] <Nop>
nmap <Space>t [toggle]

nnoremap [toggle]w <Cmd>call lazy#ToggleOption('wrap')<CR>

" ; と : の入れ替え
noremap ; :
noremap : ;

" 誤爆を防ぐ {{{
nnoremap <Space>Q q
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
nnoremap <C-CR> <ScriptCmd>call lazy#Popup_cursor_info()<CR>
" カーソル下のハイライトの情報表示
" https://zenn.dev/vim_jp/articles/show-hlgroup-under-cursor
nnoremap <M-CR> <ScriptCmd>call lazy#ShowHighlightGroup()<CR>

" https://vim-jp.slack.com/archives/CLKR04BEF/p1667463907309639
" a = "foo" で ( "foo") でなく ("foo") を選択する
BulkMap ox a' 2i'
BulkMap ox a" 2i"
BulkMap ox a` 2i`

BulkMap nx <Space>og <Cmd>call lazy#OpenBrowserGitrepo()<CR>
" nnoremap <Space>ob <Cmd>call lazy#OpenBrowserUrlInBuffer()<CR>

" / を :s///g へ
cmap <C-t> <Esc>;s/<C-r>//

" Buffer {{{2

" 直前に閉じたファイルを開き直す
" 実際には、以前開いていたバッファを開く
noremap <C-z> <C-^>

" <C-s> でバッファ変更時のみ保存。無名はダイアログ表示
" http://d.hatena.ne.jp/tyru/20130803/cua_save
nnoremap <expr> <C-s> printf('<Cmd>%s<CR>', bufname('%') ==# '' ? 'browse confirm saveas' : 'update')
imap <C-s> <ESC><C-s>

noremap <C-n> <Cmd>enew<CR>

" open vimrc
noremap <F4> <Cmd>edit $MYVIMRC<CR>
noremap <S-F4> <Cmd>edit ~/vimfiles/plug/conf/_plugins.toml<CR>

nnoremap qt <Cmd>tabclose<CR>

nnoremap <Space><F10> <Cmd>cnfile<CR>
nnoremap <Space><F11> <Cmd>cpfile<CR>

" }}}2 Window {{{2

" Ctrl + hjkl でウィンドウ間を移動
" nnoremap  <C-h> <C-w>h
" nnoremap  <C-j> <C-w>j
" nnoremap  <C-k> <C-w>k
" nnoremap  <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+

" ウィンドウを閉じる
noremap <C-q> <Cmd>close<CR>

" split and go
" 元ネタ http://daisuzu.hatenablog.com/entry/2012/08/19/235923
nnoremap _ <Cmd>SplitAndGo split<CR>
nnoremap <bar> <Cmd>SplitAndGo vsplit<CR>
command! -count=1 -nargs=1 SplitAndGo call lazy#SplitAndGo(<q-args>)

" http://vim.g.hatena.ne.jp/ka-nacht/20090119/1232347709
nnoremap [toggle]q <Cmd>call lazy#ToggleQuickfixWindow()<CR>

" コマンドラインウィンドウを開く
" cedit に <M-i> が設定できない
nnoremap <M-;> q:
cnoremap <M-;> <C-f>
nnoremap <M-i> q:
cnoremap <M-i> <C-f>

" ウィンドウを閉じたら直前のウィンドウへ移動
autocmd vimrc WinClosed * wincmd p

" }}}2 Motion {{{2

" 表示上の行移動変更
" https://github.com/darookee/dotfiles/blob/2c11a0d322c04c549d13d9cacb282d1e44a5a3c7/vimrc#L195
noremap <expr> j v:count == 0 ? 'gj' : 'j'
" inoremap <C-n> <Cmd>normal! gj<CR>
" cnoremap <C-n> <Down>
cnoremap <expr> <C-n> pumvisible() ? '<Down>' : getcmdline() == '' ? "\<S-Down>" : "\<Down>"
" noremap  <C-n> <Down>

noremap <expr> k v:count == 0 ? 'gk' : 'k'
" inoremap <C-p> <Cmd>normal! gk<CR>
cnoremap <C-p> <Up>
" cnoremap <expr> <C-p> pumvisible() ? '<Up>' : getcmdline() == '' ? "\<S-Up>" : "\<Up>"

" plug/conf/lexima9.vim
" inoremap <C-b> <C-g>U<left>
cnoremap <C-f> <Right>
noremap  <C-f> l

" undo が分割されない左移動
inoremap <C-b> <C-g>U<left>
cnoremap <C-b> <Left>
noremap  <C-b> h

" スクロールしていくと最後一行になってしまうのを直す設定
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <M-j> max([winheight(0) - 2, 1]) .. '<C-d>' .. (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <M-k> max([winheight(0) - 2, 1]) .. '<C-u>' .. (line('.') < 1         + winheight(0) ? 'H' : 'L')

" mode nvi は smarthome でマッピング
cnoremap <C-a> <Home>
cnoremap <M-h> <Home>
cnoremap <C-e> <End>
cnoremap <M-l> <End>
onoremap <Space>h ^
onoremap <Space>l $

" 単語先頭へ進む w, 単語先頭へ戻る W
" dw で dW になるのでやめ
" noremap w W
" noremap W B

" タブ間移動
noremap <C-Tab> <Cmd>tabnext<CR>
noremap <C-S-Tab> <Cmd>tabprevious<CR>

" http://postd.cc/how-to-boost-your-vim-productivity/ & ycino@vim-jp slack THNX
def AlterG()
  if v:count > 0
    execute $'normal! {v:count}G'
  endif
enddef
nnoremap <CR> <Cmd>call AlterG()<CR>
autocmd vimrc CmdWinEnter * nnoremap <buffer> <CR> <CR>

" popup 表示中は C-k, C-j で上下候補選択
" ddc.vim, vimcomplete
" inoremap <expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'
" inoremap <expr> <C-j> pumvisible() ? '<C-n>' : '<C-j>'

" matchup.vim
" nnoremap <expr> %  lazy#PercentExpr()

" }}}2 Yank, Paste {{{2

" OS クリップボード {{{3
" 切り取り
xnoremap <Space>d "+d

" 貼り付け
noremap! <C-v> <C-r>+
nnoremap <C-v> "+gP
" kyo86@vim-jp slack 2025-08-05
xnoremap <Space>p "+P
xnoremap <C-v> "+P
tnoremap <C-v> <C-w>"+

" コピー
" yank でカーソル位置をそのままにする
" atusy@vim-jp slack 2025-08-08
" https://blog.atusy.net/2025/06/03/vim-contextful-mark/
xnoremap y myy`y
xnoremap <Space>y my"+y`y
nnoremap Y y$
nnoremap <Space>y "+y
nnoremap <Space>Y "+y$

" バッファのフルパス
nnoremap <expr> <Space>y% '<Cmd>let @+ = "' .. substitute(expand("%:p"), "\\", "\\\\\\", "g") .. '"<CR>'

" バッファ全体
nnoremap <Space>ye <Cmd>%y+<CR>

" 現在行 (行頭空白、行末空白・改行を除く)
" nnoremap <Space>yy <Cmd>call vimrc#linecopy()<CR>

" nnoremap <Space>Y "+y$
"}}}3

" nnoremap Y y$

" ペーストした内容を選択
" インデント以外に何か使い道あるのかな？
" https://zenn.dev/vim_jp/articles/43d021f461f3a4#%E7%9B%B4%E5%89%8D%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E7%AF%84%E5%9B%B2%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
nnoremap gp `[v`]

" Visual ペースト時にレジスタの変更を防止
" https://zenn.dev/vim_jp/articles/43d021f461f3a4#visual-%E3%83%9A%E3%83%BC%E3%82%B9%E3%83%88%E6%99%82%E3%81%AB%E3%83%AC%E3%82%B8%E3%82%B9%E3%82%BF%E3%81%AE%E5%A4%89%E6%9B%B4%E3%82%92%E9%98%B2%E6%AD%A2
xnoremap p P

" }}}2 Edit {{{2
" lexima で C-h と BS を同じ挙動にする
map! <C-h> <BS>

" Del
noremap! <C-d> <Del>
snoremap <C-d> a<BS>

" 行頭まで削除
inoremap <C-BS> <C-u>
nnoremap <C-BS> d0

" 行末まで削除
" plug/conf/searchx.vim
" cnoremap <expr><C-k> repeat('<Del>', strchars(getcmdline()[getcmdpos() - 1:]))
"
" plug/conf/ddc.vim FIXME? ddc を使う場合に vsnip の設定とかち合うかも
" plug/conf/vsnip.vim
" inoremap <C-k>  <C-o>D

" カーソル移動せずに改行挿入
nnoremap <expr> <M-o> lazy#BlankBelow()
nnoremap <expr> <M-O> lazy#BlankAbove()

" 日付入力
inoremap <C-r><C-d> <C-r>=strftime("%F")<CR>
nmap <F6> <ESC>i<C-r><C-d><ESC>
imap <F6> <C-r><C-d>

" smart indent when entering insert mode with i on empty lines
" https://github.com/yukiycino-dotfiles/dotfiles/blob/ff76abc26557f3158b10cf5bedc92767fad4877d/.vimrc#L246-L248
nnoremap <expr> i len(getline('.')) ? 'i' : '"_cc'
nnoremap <expr> a len(getline('.')) ? 'a' : '"_cc'
nnoremap <expr> A len(getline('.')) ? 'A' : '"_cc'

" コメント開始文字列を挿入せずに改行
" https://www.key-p.com/blog/staff/archives/104879
inoremap <S-CR> <CR><C-u>
nnoremap <S-CR> o<C-u>

" visual repeat
" http://vim.wikia.com/wiki/Repeat_command_on_each_line_in_visual_block
" Can't use <Cmd>
xnoremap . :normal .<CR>

" Visual 選択状態でインデント後も選択状態のままにする
" https://twitter.com/mattn_jp/status/1202603537521401856
xnoremap < <gv
xnoremap <S-Tab> <gv
xnoremap > >gv
xnoremap <Tab> >gv

" @r に置換マクロ登録
let @r = ';%s/[^\\]\+\.\([^\\]\+$\)/00001.\1/gg2nvveGg'

" A-m だけで m にマクロ登録
nnoremap <expr> <A-m> reg_recording() == 'm' ? 'q' : 'qm'

" 選択範囲を置換する {{{
" http://qiita.com/itmammoth/items/312246b4b7688875d023
nnoremap <Space># "zyiw:%s/\<<C-r>z\>/<C-r>z/gc<left><left><left>

" xnoremap <Space># "zy:%s/\V<C-r>z/<C-r>z/g<left><left>
" xnoremap <Space># <Cmd>call <SID>set_vsearch()<CR>:s/<C-r>///gc<Left><Left><Left>
" " FIXME getregion() を使うと z をつぶさなくて済むと思ったけど、行全体が yank のハイライトされる
" " getregion(getpos('.'), getpos('v'))[0]->escape('/\')->substitute('\n', '\\n', 'g')
" function s:set_vsearch()
"   noautocmd let @/ = '\V' .. getregion(getpos('.'), getpos('v'))[0]->escape('/\')->substitute('\n', '\\n', 'g')
" endfunction
xnoremap <Space># :<C-u>call <SID>set_vsearch()<CR>:%s/<C-r>//<C-r>z/gc<Left><Left><Left>
 function s:set_vsearch()
  silent noautocmd normal! gv"zy
  let @/ = '\V' .. escape(@z, '/\')->substitute('\n', '\\n', 'g')
endfunction
" }}}

" vim-jp.slack
" du で _ の前まで削除など
onoremap u t_
" dU で 大文字の前まで削除など
onoremap U <Cmd>call <SID>numSearchLine('[A-Z]', v:count1, '')<CR>
function s:numSearchLine(ptn, num, opt)
  for i in range(a:num)
    call search(a:ptn, a:opt, line('.'))
  endfor
endfunction

" 直前に入力した単語を大文字へ
inoremap <expr> <C-u> $'<C-w>{lazy#ToupperPrevWord()}'

" }}}2 Search {{{2

" clear hlsearch
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>

" incsearch 中に前後の候補へカーソル移動
cnoremap <M-j> <C-g>
cnoremap <M-k> <C-t>

" 現在のバッファから grep
" call execute(AddLeft('nnoremap <Space>/ :vimgrep /', '/ %'))

" }}}2

" }}}1 Git {{{1
call extend(g:vimrc_altercmd_dic, {'git': '!git'})

" Suppress git add -p message
let $LANG = 'ja_JP.UTF-8'
" nnoremap <Space>gl <Cmd>!git gl -100<CR>
nnoremap <Space>gd <Cmd>!git diff HEAD<CR>
nnoremap <Space>gD <Cmd>!git diff HEAD %<CR>

" 変更量が多いと表示が溢れてよくわからない。
" git status でも pager を使えるように設定が必要。
" git config --global pager.branch "cure"
nnoremap <Space>gs <Cmd>!git status -v<CR>

nnoremap <Space>gh :!git cherry-pick<Space>

" add {{{2
" コミット対象の hunk を選択する場合: gad -> gc
" コミットメッセージに詳細を書く場合: gu -> gc
nnoremap <Space>gad :!git add --patch<CR>
nnoremap <Space>gai <Cmd>!git add --interactive<CR>
nnoremap <Space>gu <Cmd>silent !git add --update<CR>
"}}}2 commit {{{2
nnoremap <Space>gc <Cmd>!git commit -v<CR>
nnoremap <Space>gam <Cmd>!git commit --amend<CR>
" 単純なコミットメッセージの場合: gn
nnoremap <Space>gn :!git commit --all -v -m ""<Left>
nnoremap <Space>gN <Cmd>!git commit --all -v<CR>
"}}}2 branch {{{2
" nnoremap <silent> <Space>gbb :!git branch<CR>
" ctrlp-generic
" nnoremap <Space>gbb <Cmd>call popup_atcursor(systemlist('git branch'), #{ moved: "any", border: [], minwidth: &columns/3, minheight: &lines/4 })<CR>
nnoremap <Space>gbc :!git switch -c<Space>
" @ は現在ブランチの最新コミット
nnoremap <Space>gp :!git push origin @
" 直前のブランチに戻す。念のため Enterは自分で
nnoremap <Space>gbw :!git switch -

" 直前のコミットを master にする場合: gbr -> g-
" rename current branch
nnoremap <Space>gbm :!git branch -m temp
nnoremap <Space>gbr :!git branch -m temp
" switch new branch (default: master) from last commit (default: master)
call AddLeft('nnoremap <Space>g- :!git switch -c master', ' HEAD~')->execute()
" restore temp branch
" ctrlp-launcher
" nnoremap <Space>gr :!git restore --source=temp .
" delete branch
nnoremap <Space>gbd :!git branch -D temp
" }}}2

" }}}1 others {{{1
" 無名レジスタが更新された場合に、使用中のオペレータの種類（c/d/y）の名前を冠するレジスタに内容をコピー
" https://blog.atusy.net/2023/12/17/vim-easy-to-remember-regnames/
" 参考にさせてもらって変更
" c / d / y で更新した直前の無名レジスタの内容を c / d / y に入れる
" 0 に yank、- に c, d で削除した内容が入っているけどとっさに判断できないので
" c で無名レジスタを消しちゃったという場合は C-r c で直前の無名レジスタの内容を入力できる
autocmd vimrc TextYankPost * call vimrc#UseEasyRegname()

" }}}1 Terminal {{{1

tnoremap <C-p> <Up>
tnoremap <C-n> <Down>
tnoremap <C-f> <Right>
tnoremap <C-b> <Left>
tnoremap <C-a> <Home>
tnoremap <C-e> <End>

tnoremap <C-d> <Delete>
tnoremap <C-h> <BS>

" }}}1 GUI {{{1
if has('gui_running')
  " font {{{2
  " set guifont=BDF_M+:h9
  " set guifont=Cica:h11
  " set guifont=MyricaM_M:h11
  " set guifont=UD_デジタル_教科書体_N-R:h11
  set guifont=HackGen:h14

  " 行間隔の設定
  set linespace=1

  " 一部のUCS文字の幅を2倍の幅とする
  " set ambiwidth=double

  " Use colored emoji
  set renderoptions=type:directx,renmode:5,scrlines:1
  " }}}2 window {{{2

  " 最大化で起動
  autocmd vimrc GUIEnter * simalt ~x

  " Make <M-Space> same as ordinal applications on MS Windows
  " https://github.com/tyru/config/blob/3e16b655e3dea14d55c4fbc6f41ec314e3480c5c/home/volt/rc/default/vimrc.vim#L581
  nnoremap <M-Space> <Cmd>simalt ~<CR>

  " }}}2 colorscheme {{{2
  " https://github.com/vim-jp/reading-vimrc/wiki/vimrcアンチパターン
  function DefineMyHighlights()
    " IME の有効無効でカーソルの色を変更する。
    if has('multi_byte_ime')
      highlight CursorIM guifg=NONE guibg=Green gui=NONE
    endif

    " cursorline は特に目立たせないときに有効にするので、そのときに見やすい値へ
    highlight CursorLine gui=underline guifg=NONE guibg=NONE

    " Tabpanel の非アクティブタブページから underline を削除
    " spring-night のデフォルトだと TabLine とリンクしているようなので、その値から cterm, gui の underline を NONE へ
    highlight TabPanel cterm=NONE ctermfg=103 ctermbg=238 gui=NONE guifg=#8d9eb2 guibg=#536273
  endfunction
  autocmd vimrc ColorScheme * :call DefineMyHighlights()

  syntax on
  let s:favColorscheme = 'spring-night'
  if !empty(globpath(&rtp, $'colors/{s:favColorscheme}.vim'))
    call execute($'colorscheme {s:favColorscheme}')
  endif
  " }}}

endif

" }}}1

" debug
" def で定義している関数を変更、追加した場合は一時的にコメントを外す。
" defcompile
