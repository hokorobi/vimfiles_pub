"==============================================================================
" Vim configuration
" Author:   hokorobi
" Platform: Windows
" Vim:      KaoriYa gVim
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


" Command {{{1

" エンコードを指定して開き直す
command! OpenUtf8 :e ++enc=utf-8
command! OpenSjis :e ++enc=cp932

" エンコードを変換
command! ToUtf8 :set fileencoding=utf-8
command! ToSjis :set fileencoding=cp932

" ウィンドウが複数開いていたら新しいタブで開く
" 外部からファイルを渡して呼び出すことはできないのか？
"command! -nargs=1 Ee call vimrc#YetAnotherEdit('<args>')
" call extend(g:vimrc_altercmd_dic, {'ee': 'Ee'})

" http://d.hatena.ne.jp/fuenor/20090907/1252315621
" 並んだ数字に対して行数分 <C-a> を実行。なので同じ数字が並んでいないと意図した結果にならない
" RengBang では、対象の文字列が正規表現でうまく絞り込めない時に使用
" g<C-a> が使えるバージョンなら不要。挙動は少し違うけど
command! -count -nargs=0 RengBangVertical
      \ let snf=&nf|set nf-=octal|let cl = col('.')|for nc in range(1, <count>?<count>-line('.'):1)|execute 'normal! j' . nc . '<C-a>'|call cursor('.', cl)|endfor|let &nf=snf|unlet cl snf

" / と :s///g をトグル {{{
" https://raw.githubusercontent.com/cohama/.vim/master/.vimrc
cnoremap <expr> <C-t> vimrc#ToggleSubstituteSearch(getcmdtype(), getcmdline())

" https://github.com/DeaR/dotfiles/blob/master/.vimrc
" Multi Mode Mapping: {{{
" map
command! -complete=mapping -nargs=*
      \ NVmap
      \ nmap <args>| vmap <args>
command! -complete=mapping -nargs=*
      \ NXmap
      \ nmap <args>| xmap <args>
command! -complete=mapping -nargs=*
      \ NSmap
      \ nmap <args>| smap <args>
command! -complete=mapping -nargs=*
      \ NOmap
      \ nmap <args>| omap <args>
command! -complete=mapping -nargs=*
      \ VOmap
      \ vmap <args>| omap <args>
command! -complete=mapping -nargs=*
      \ XOmap
      \ xmap <args>| omap <args>
command! -complete=mapping -nargs=*
      \ SOmap
      \ smap <args>| omap <args>
command! -complete=mapping -nargs=*
      \ NXOmap
      \ nmap <args>| xmap <args>| omap <args>
command! -complete=mapping -nargs=*
      \ NSOmap
      \ nmap <args>| smap <args>| omap <args>

" noremap
command! -complete=mapping -nargs=*
      \ ICnoremap
      \ inoremap <args>| cnoremap <args>
command! -complete=mapping -nargs=*
      \ NVnoremap
      \ nnoremap <args>| vnoremap <args>
command! -complete=mapping -nargs=*
      \ NXnoremap
      \ nnoremap <args>| xnoremap <args>
command! -complete=mapping -nargs=*
      \ NSnoremap
      \ nnoremap <args>| snoremap <args>
command! -complete=mapping -nargs=*
      \ NOnoremap
      \ nnoremap <args>| onoremap <args>
command! -complete=mapping -nargs=*
      \ VOnoremap
      \ vnoremap <args>| onoremap <args>
command! -complete=mapping -nargs=*
      \ XOnoremap
      \ xnoremap <args>| onoremap <args>
command! -complete=mapping -nargs=*
      \ SOnoremap
      \ snoremap <args>| onoremap <args>
command! -complete=mapping -nargs=*
      \ NXOnoremap
      \ nnoremap <args>| xnoremap <args>| onoremap <args>
command! -complete=mapping -nargs=*
      \ NSOnoremap
      \ nnoremap <args>| snoremap <args>| onoremap <args>
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

" 今開いているファイルをリネーム
" https://github.com/cohama/.vim/blob/master/.vimrc
command! -nargs=1 RenameMe call vimrc#RenameMe(<q-args>)

" cd
" http://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
command! -nargs=? -complete=dir -bang CD call vimrc#ChangeCurrentDir('<args>', '<bang>')

" diff xdoc2txt
" vimdiff でファイルを開いた後に xdoc2txt でフィルタリングした結果を diffupdate
if Vimrc_executable('xdoc2txt')
  command! -nargs=0 DiffXdoc2txt call vimrc#DiffXdoc2txt()
endif

" , 区切りの文字列をソートする（行全体）
" http://vim.1045645.n5.nabble.com/sort-words-within-a-line-td2651668.html
" TODO: 選択範囲のみに適用
" ひとつ目の引数は区切り文字。なければ ,
" ふたつ目の引数は新しい区切り文字。なければひとつ目の区切り文字と同じ
" SortLine! で区切り文字の後ろにスペースを付けない
command! -nargs=* -bang SortLine call vimrc#sortline(<q-bang>, <f-args>)

" カーソル下の単語を vimgrep
command! -nargs=1 VimGrepCurrent vimgrep <args> % | cw
nnoremap <expr> <Leader>* ':<C-u>VimGrepCurrent ' . expand('<cword>') . '<CR>'

" jq
" http://qiita.com/tekkoc/items/324d736f68b0f27680b8
if Vimrc_executable('jq')
  command! -nargs=? Jq call vimrc#Jq(<f-args>)
  call extend(g:vimrc_altercmd_dic, {'jq': 'Jq'})
endif

" ウィンドウで表示しているバッファで diffthis
call extend(g:vimrc_altercmd_dic, {'dt': 'windo diffthis'})

" ファイラからの起動時に検索文字列を指定するのは使いにくいので、コマンド実行後に検索文字列を入力できるようにする
" pt 用
if Vimrc_executable('pt')
  command! -nargs=? GrepWrap call vimrc#GrepWrap(<f-args>)
  call extend(g:vimrc_altercmd_dic, {'gw': 'GrepWrap'})
  call extend(g:vimrc_altercmd_dic, {'grepw[rap]': 'GrepWrap'})
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

" undo-persistence
if has('persistent_undo')
  " persistent-undo(無限undo)を使う
  set undofile
  " undoファイルを保存するディレクトリの設定
  let &undodir = expand('~/_vim/info/undo')
  " undodirを作成しておく
  silent! call mkdir(&undodir, 'p')
endif

" }}}2 Function {{{2

" クリップボードをOSと共有
" x なども共有されてしまうのでやめ
"set clipboard=unnamed

" セッションにオプションとマッピングは保存しない
set sessionoptions-=options

" スペルチェックを無効
set nospell

" 数値を八進数として解釈しない
set nrformats-=octal

" 矩形選択で長さの足りない行はスペース扱い
set virtualedit=block

" : コマンドの履歴保持数など
set history=1000

" メモリ使用量
set maxmem=2000000 maxmemtot=2000000

" " をエスケープしない
" Hg ci -m "hoge fuga" の引数を "hoge fuga" そのままで渡したいため
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

" 起動時のメッセージを非表示
set shortmess+=I

" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch

" 常にタブラインを表示
set showtabline=2

" コマンド行の高さ
set cmdheight=2

" don't syntax highlight long lines
set synmaxcol=256

" 長い行を折り返して表示 (nowrap:折り返さない)
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
let &showbreak = '> '

" マウス有効, 入力中にマウスカーソル非表示
set mouse=a mousehide

" 新規ウィンドウは下、右に開く
set splitbelow splitright
" ウィンドウ分割時にウィンドウの高さ、幅を変えない
set noequalalways

" メニュー非表示時に起動高速化
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

" $VIMRUNTIME/menu.vim を読み込まない M
" メニューを非表示にする -m
" メニュー項目の切り離しを無効にする（よくわからん） -t
" gVimでもテキストベースのタブページを使う -e
" ツールバーを非表示 -T
set guioptions+=M guioptions-=m guioptions-=t guioptions-=e guioptions-=T

" }}}2 edit {{{2

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

function! s:SetFormatoptions(isSetlocal) abort
  let setcmd = a:isSetlocal == 1 ? 'setlocal' : 'set'
  " +M マルチバイトの連結は空白なし
  " -t 自動折返し止め
  " -c 自動折返して、現在のコメント開始文字列を自動挿入はやめ
  execute setcmd . ' formatoptions+=M formatoptions-=t formatoptions-=c'
  " コメントリーダーを除いて連結
  if v:version >= 704
    execute setcmd . ' formatoptions+=j'
  endif
endfunction
call s:SetFormatoptions(0)

" ファイル末尾に改行を追加しない
if has('patch-7.4.785')
  set nofixendofline
endif

" }}}2 complete {{{2

" 補完メニューの高さ指定
set pumheight=10
" 補完のオプションから preview を除く、候補がひとつのときもメニュー表示
set completeopt+=menuone completeopt-=preview completeopt-=menu
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" }}}2 indent {{{2

" indent
" 賢い indent
set cindent
" タブの画面上での幅
set tabstop=4
" キーボードで<Tab>キーを押した時に挿入される空白の量。tabstop の値を使う
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

" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan

" }}}2 grep {{{2

" grep プログラムに pt を指定
if Vimrc_executable('pt')
  let &grepprg = 'pt /nogroup /nocolor /column /S'
  " /column で桁を表示しているので %c も使うパターンを追加
  set grepformat^=%f:%l:%c:%m

  " http://stackoverflow.com/questions/15393301/automatically-sort-quickfix-entries-by-line-text-in-vim
  " pt で grep を実行した後に結果をパス順にしたかったので sort
  autocmd vimrc QuickFixCmdPost * call vimrc#SortQuickfix('vimrc#QfStrCmp')
endif

" grep 後に quickfix-window を表示
autocmd vimrc QuickFixCmdPost *grep* cwindow

" }}}2

" ローカル設定の読み込み
let g:vimrc_local = '~/_vim/_vimrc.local'
if filereadable(expand(g:vimrc_local))
  execute 'source' . g:vimrc_local
endif

" }}}1 Plugin {{{1

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
" use parenmatch
let g:loaded_matchparen = 1

" netrw {{{
" disable netrw.vim
" vim-protocol で代用
let g:loaded_netrw             = 1

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

"       dein {{{2
set runtimepath+=$HOME/_vim/dein/repos/github.com/Shougo/dein.vim
let s:vimrcs = []
let s:toml = expand('~/vimfiles/rc/plugins.tml')
call add(s:vimrcs, s:toml)
call add(s:vimrcs, expand('$VIM/gvimrc_local.vim'))
call add(s:vimrcs, expand('~/vimfiles/vimrc'))
call add(s:vimrcs, expand('$VIM/vimrc_local.vim'))
let s:path = expand('~/_vim/dein')
let g:dein#install_log_filename = expand('~/_vim/dein/dein.log')

if dein#load_state(s:path)
  call dein#begin(s:path, s:vimrcs)
  call dein#load_toml(s:toml)
  call dein#end()
  call dein#save_state()
endif

call extend(g:vimrc_altercmd_dic, {'du': 'call dein#update()'})
call extend(g:vimrc_altercmd_dic, {'di': 'call dein#install()'})
call extend(g:vimrc_altercmd_dic, {'dl': 'view ' . expand('~/_vim/dein/dein.log')})
call extend(g:vimrc_altercmd_dic, {'dr': 'call dein#recache_runtimepath()'})

filetype plugin indent on

" }}}   changelog {{{2

let g:changelog_username=''
let g:changelog_dateformat='%Y-%m-%d (%a)'
let g:changelog_new_date_format="%d\n\n%c\n"

" }}}2

" }}}1 Filetype {{{1

" vimrc で set で設定しても上書きされているっぽいので autocmd にした
autocmd vimrc FileType * call s:SetFormatoptions(1)

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

" バイナリファイルのテキスト化
" http://vim.wikia.com/wiki/VimTip1356
if Vimrc_executable('xdoc2txt')
  " xlsx などが zip として表示されることを避ける
  " デフォルトプラグインの停止で設定済みになっているのでここでは不要
  " let g:loaded_zipPlugin= 1
  autocmd vimrc BufReadPre *.{doc,docx,pdf,ppt,pptx,xls,xlsx} setlocal readonly buftype=nofile noswapfile
  autocmd vimrc BufReadPost *.{doc,docx,pdf,ppt,pptx,xls,xlsx} %!xdoc2txt "%"
endif

" PPx 用
autocmd vimrc Filetype cfg setlocal noexpandtab
autocmd vimrc BufNewFile,BufRead *.js9 set filetype=javascript

" diff バッファは最初から折り返す
autocmd vimrc FilterWritePre * if &diff | setlocal wrap< | endif

" markdown
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \]

" }}}1 Key Mapping {{{1

" Space 単体は何もしない
nnoremap <Space> <Nop>

" toggle
nmap <Leader>t  [toggle]
nnoremap [toggle]  <Nop>

nnoremap <silent> [toggle]w :<C-u>call vimrc#toggle_option('wrap')<CR>
nnoremap <silent> <C-F3> :<C-u>call vimrc#toggle_option('wrap')<CR>

" ; と : の入れ替え
noremap ; :
noremap : ;

" 誤爆を防ぐ
nnoremap Q q
nnoremap q <Nop>
nnoremap <Leader>Q q

" 誤操作防止のため保存せずに閉じるを無効へ
nnoremap ZQ <Nop>

" ビジュアルモードローテーション
" ノーマルモードから v でビジュアルモード、さらに v で矩形ビジュアルモード、
" さらに v でノーマルモード
vnoremap v <C-v>

" help
nnoremap H :h<Space>

" nnoremap <silent> <Leader>cd :<C-u>CD<CR>

" ペーストした内容を選択
" インデント以外に何か使い道あるのかな？
nnoremap <expr> gp '`['.strpart(getregtype(),0,1).'`]'

" lexima の <CR> の定義を使うため
" if のある行などでも発動するので誤爆が多すぎる
" nmap o A<CR>

" buffer {{{2

" 直前に閉じたファイルを開き直す
" 実際には、以前開いていたバッファを開くみたい
noremap <C-z> <C-^>

" バッファ移動
noremap b :<C-u>bn<CR>
" noremap <C-Right> :<C-u>bn<CR>
noremap B :<C-u>bp<CR>
" noremap <C-Left> :<C-u>bp<CR>

" <C-s> でバッファ変更時のみ保存。無名はダイアログ表示
" http://d.hatena.ne.jp/tyru/20130803/cua_save
inoremap <script> <SID>(gui-save) <C-o><SID>(gui-save)
inoremap <silent> <script> <C-s> <SID>(gui-save)<ESC>
nnoremap <silent> <script> <C-s> <SID>(gui-save)
nnoremap <silent> <script> <Leader>s <SID>(gui-save)
" nmap <silent> <script> <Leader>w <SID>(gui-save)
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

nnoremap <silent> <Leader><BS>  :<C-u>bdelete<CR>

" vimrc 開く、読み込み
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
noremap <F4> :Ev<CR>
noremap <F5> :Rv<CR>

" }}}2 Window {{{2

" Ctrl + hjkl でウィンドウ間を移動
noremap  <C-h> <C-w>h
noremap  <C-j> <C-w>j
noremap  <C-k> <C-w>k
noremap  <C-l> <C-w>l
inoremap <C-l> <C-O><C-w><C-w>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" ウィンドウを閉じる
noremap <C-q> :<C-u>close<CR>

" split and go
" 元ネタ http://daisuzu.hatenablog.com/entry/2012/08/19/235923
nnoremap <silent> _ :SplitAndGo split<CR>
nnoremap <silent> <bar> :SplitAndGo vsplit<CR>
command! -count=1 -nargs=1 SplitAndGo call vimrc#SplitAndGo(<q-args>)

" http://vim.g.hatena.ne.jp/ka-nacht/20090119/1232347709
nnoremap <silent> [toggle]q :<C-u>call vimrc#toggle_quickfix_window()<CR>

" }}}2 Movement {{{2

" 表示上の行移動変更
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" カーソル移動 {{{
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap! <M-j> <PageDown>
noremap <expr> <M-j> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap! <M-k> <PageUp>
noremap <expr> <M-k> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')

onoremap <silent> <Leader>h ^
onoremap <silent> <Leader>l $

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
noremap <F10> :cn<CR>
noremap <S-F10> :cp<CR>

" http://postd.cc/how-to-boost-your-vim-productivity/
nnoremap <CR> G
nnoremap <BS> gg

" https://raw.githubusercontent.com/todashuta/.dotfiles/aa1f494c4f223113e619f2551161af2176df1deb/.vimrc#L693
" insert mode から戻るときにカーソルを移動させない
" その際 jumplist も更新しない
inoremap <silent> <Esc> <Esc>:keepjumps normal! `^<CR>

" http://qiita.com/itmammoth/items/312246b4b7688875d023
" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" }}}2 Yank {{{2

" クリップボードへコピー・切り取り・貼り付け
vnoremap <Leader>y "+y
vnoremap <C-c> "+y
vnoremap <C-x> "+d

noremap! <C-v> <MiddleMouse>
nnoremap <C-v> "+gP

" バッファ全体をクリップボードへコピー
nnoremap <Leader>ye :<C-u>%y+<CR>

" 行をクリップボードへコピー（末尾改行なし、カーソル移動なし）
nnoremap <silent> <Leader>yy :call vimrc#linecopy()<CR>

" keep cursor position when yanking in visual mode
xnoremap <silent> <expr> y "ygv" . mode()
xnoremap <silent> <expr> Y "Ygv" . mode()

" c: Change into the blackhole register to not clobber the last yank.
nnoremap c "_c
nnoremap C "_C

" }}}2 Edit {{{2
" BS
noremap! <C-h> <BS>
" nnoremap <C-h> X

" Del
noremap! <C-d> <Del>
noremap  <C-d> x

" 行頭まで削除
inoremap <C-Backspace> <C-u>
nnoremap <C-Backspace> d0

" バッファ全体をインデント
noremap <F7> mzgg=G`z<CR>

" カーソル移動せずに改行挿入
nnoremap <M-o> :<C-U>call append(line('.'), repeat([''], v:count1))<CR>
nnoremap <M-O> :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>

" 日付入力
nnoremap <F6> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR><ESC>
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" smart indent when entering insert mode with i on empty lines
" http://qiita.com/Qureana/items/4790be39e04add101ee2
nnoremap <expr> i vimrc#IndentWithI()

" "レジスタから挿入
ICnoremap <C-R> <C-R>"

" カーソル下の文字が数字だったらインクリメント・デクリメント、違ったら Switch
" FIXME: ビジュアルモードとノーマルモードの動作が逆になる
noremap <silent> + :Myincrement<CR>
noremap <silent> - :Mydecrement<CR>
command! -nargs=0 -range Myincrement call vimrc#Mycrement('+', <line1>, <line2>)
command! -nargs=0 -range Mydecrement call vimrc#Mycrement('-', <line1>, <line2>)

" }}}2 Search {{{2

" インクリメンタルサーチで /, ? を簡単に検索できるようにする
" http://vim-jp.org/vim-users-jp/2009/10/22/Hack-91.html
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" インクリメンタルサーチの最中に次、前の候補に移動する
" インクリメンタルサーチの最中にカーソル位置の単語を入れる <C-r><C-w> などが使
" えなくなるので、とりあえずコメントアウト
" cnoremap <expr> <C-s> getcmdtype() == '?' ? "<CR>/<Up>" : getcmdtype() == '/' ? "<CR>/<Up>" : "<C-s>"
" cnoremap <expr> <C-r> getcmdtype() == '?' ? "<CR>?<Up>" : getcmdtype() == '/' ? "<CR>?<Up>" : "<C-r>"

"migemo
" / は incsearch.vim で使うのでコメントアウト
" nnoremap / g/

" clear hlsearch
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" 置換繰り返し。フラグも含む
NXnoremap & :&&<CR>

" 置換
" nnoremap gs :<C-u>%s///gc<Left><Left><Left><Left>
" vnoremap gs :s///gc<Left><Left><Left><Left>

" lexima や neocomplete で C-h と BS を同じ挙動にする
imap <C-h> <BS>
cmap <C-h> <BS>

" https://raw.githubusercontent.com/machakann/vimrc/3dc16ac1ae31197e35bebdf3f0fbf275117478bd/.vimrc
" get into incert mode at a character before the end of line.
" call hoge(piyo)
"               # I want to insert here.
" NOTE: 'nnoremap gA $i' is not good, because it is not repeatable.
nnoremap gA A<C-g>U<Left>

" http://qiita.com/itmammoth/items/312246b4b7688875d023
" ハイライトしてから置換する
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

" incsearch 中に前後の候補へカーソル移動
if has('patch-7.4.2268')
  cnoremap <C-j> <C-g>
  cnoremap <C-k> <C-t>
endif

" }}}2

" }}}1 GUI {{{1
if has('gui_running')
  " font {{{
  set guifont=BDF_M+:h9
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
  " }}}

  " タブ文字などを表示
  set list listchars=eol:$,tab:»\ ,trail:_,extends:\

  " 挿入モード・検索モードのデフォルトのIME状態設定
  " gvimrc を読み込まないようにしたので拝借
  if has('multi_byte_ime')
    set iminsert=0 imsearch=0
  endif

  " 最大化で起動
  autocmd vimrc GUIEnter * simalt ~x
  let g:vimrc_fullscreen = 1

  " fullscreen toggle
  nnoremap [toggle]<Space> :<C-u>call vimrc#ToggleFullScreen()<CR>

  " colorscheme
  function! DefineMyHighlights()
    if g:colors_name is# 'hybrid'
      highlight Visual guifg=Black guibg=#d33682 ctermbg=LightRed term=reverse
      " 行番号が見づらかった。
      highlight LineNr ctermfg=14 guifg=#8d7571 guibg=#1d1f21
      " カーソル行もみやすく
      highlight CursorLine gui=underline guifg=NONE guibg=NONE
      " タブ文字を見やすく
      highlight SpecialKey guifg=#707880

      " IME の有効無効でカーソルの色を変更する。
      " colorscheme の後ろに定義する。
      if has('multi_byte_ime')
        highlight CursorIM guifg=NONE guibg=Green gui=NONE
      endif
    endif
  endfunction
  autocmd vimrc ColorScheme * :call DefineMyHighlights()

  syntax on
  colorscheme hybrid

  " 'cursorline' を必要な時にだけ有効にする
  " http://d.hatena.ne.jp/thinca/20090530/1243615055
  augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
    autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
    autocmd WinEnter * call s:auto_cursorline('WinEnter')
    autocmd WinLeave * call s:auto_cursorline('WinLeave')

    let s:cursorline_lock = 0
    function! s:auto_cursorline(event)
      if a:event ==# 'WinEnter'
        setlocal cursorline
        let s:cursorline_lock = 2
      elseif a:event ==# 'WinLeave'
        setlocal nocursorline
      elseif a:event ==# 'CursorMoved'
        if s:cursorline_lock
          if 1 < s:cursorline_lock
            let s:cursorline_lock = 1
          else
            setlocal nocursorline
            let s:cursorline_lock = 0
          endif
        endif
      elseif a:event ==# 'CursorHold'
        setlocal cursorline
        let s:cursorline_lock = 1
      endif
    endfunction
  augroup END

endif

" }}}

