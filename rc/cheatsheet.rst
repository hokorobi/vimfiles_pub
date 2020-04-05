Command
========

* `M-i` : (c) コマンドラインウィンドウ表示

Movement
========

* `[z` `]z`  : 現在の折りたたみの先頭/末尾へ移動
* `zj` `zk`  : 次/前の折りたたみの先頭/末尾へ移動。feat. submode 連続して j, k 入力で次、前へ移動
* `gt` `gT`  : 前の／次のタブを表示。feat. submode 連続して t, T 入力で次、前へ移動
* `g;` `g,`  : 変更した位置への移動。feat. submode 連続して ;, , 入力で次、前へ移動
* `:jumps`   : ジャンプの履歴表示
* `C-I`      : ジャンプの履歴を進む
* `o`        : (v) 範囲開始指定をやり直し
* `<Space>;` : 直前の f, F, t, F を繰り返す。 feat. easymotion
* `<Space>,` : 直前の f, F, t, F を逆方向に繰り返す。 feat. easymotion


Select
=======

* `gv` : 最後に使用したのと同じ範囲のビジュアルモードを開始する


Edit
====

* `F6`                      : (ni) 日付の入力
* `~`                       : 大文字小文字入れ替え
* `:ISetting[!] [st][0-9]`  : インデントの変更。s2 なら space で幅2 に変更。! 付きなら Retab も実行
* `:ExpandSerialNumber`     : hoge [100-120] fuga などと入力して実行すると、hoge 100 fuga, hoge 101 fuga が各行に展開される。 feat. ExpandSerialNumber
                            : [0xa-0xf] 入力後に実行すると a-f を各行に展開 feat. ExpandSerialNumber
* `:SortLine`               : 行全体で , 区切りの文字列をソートする
* `<Leader>a` / `<Leader>x` : (v) 選択範囲をインクリメント / デクリメント
* `:v/hoge/d`               : hoge を含む行のみを残して削除
* `:Capture g/hoge/p`       : hoge を含む行のみを Capture バッファへ出力。 feat. Capture
* `:vim // %`               : 直前の検索条件を含む行のみを Quickfix へ出力
* `:g/hoge/d`               : hoge を含む行を削除
* `:g/Second/s/bar/foo/g`   : Second を含む行に存在する bar をすべて foo に置換する。
* `:s//bar/`                : 直前の / 検索の合致内容を bar に置換する。
* `:g/hoge/cmd`             : hoge を含む行に対して :cmd を実行
* `gs`                      : 要素の移動を可能にする swap mode (j, k: 対象選択、h, l: 対称移動、s, S: ソート昇順、降順、r: 反転、g, G: グループ化、解除) に入る。. で繰り返し可能 feat. swap
* `g>`                      : 要素を右に移動 feat. swap
* `g<`                      : 要素を左に移動 feat. swap
* `g<C-a>`                  : (v) 選択範囲の数値を漸増的に N ずつ増やす。最初の行の数値から増加する。
* `cxiw`                    : 入れ替えたい単語で実行することで入れ替えができる。 feat. vim-exchange
* `cxc`                     : 入れ替え候補のキャンセル feat. vim-exchange
* `X`                       : (v) 入れ替えたい単語で実行することで入れ替えができる。 feat. vim-exchange
* `cxx`                     : (v) X で選択した行と、これを実行した行を入れ替え。 feat. vim-exchange
* `#`                       : (n: カーソル下の単語|v: 選択文字列) をハイライトしてから置換
* `^M などの入力`           : vim --clean filename で起動。Insert mode で Ctrl+v Ctrl+m など
* `<C-R>"`                  : (i) 直前のレジスタから Paste
* `<C-R>0`                  : (i) 一つ前のレジスタから Paste。cw<C-R>" だと変更前の単語が Paste されるので、こちらを使う。
* `sdt`                     : HTML のタグだけを削除。 feat. sandwich
* `M-i`                     : (c) コマンドラインウィンドウ表示
* `dNib`                    : ("(fo|o)") | にカーソルがある時に N=2 なら (foo) が、N=3なら "(foo)" が削除できる。 feat.sandwich

複数ファイルに対する処理
------------------------

* `:args {argument}`      : {argument} が対象のファイルリストとなる。{argument} は `./*.html` とか。
* `:argsadd {argument}`   : {argument} を追加。
* `:argdo %s/hoge/fuga/g` : args に続けて実行。 {argument} に対して置換が実行される
* `:vim foo ##`           : args に続けて実行。## が {argument} に置換されて実行される

. で連続して置換
-----------------

1. / で検索
2. cgn で次の合致文字列を変更
3. . で次の合致文字列を同様に置換

複数の単語に同様の変更を加える
-------------------------------

単語を <p></p> で囲む場合。

1. 最初の単語で cw<p><C-R><C-P>"</p><ESC> （<C-R><C-P>" でなく <C-R>" では駄目）
2. 次の単語で .


Easy Align
----------

* `<Space>`    : Around 1st whitespaces
* `3<Space>`   : Around 2nd whitespaces
* `-<Space>`   : Around the last whitespaces
* `-1<Space>`  : Around the 2nd to last whitespaces
* `:`          : Around 1st colon (key: value)
* `<Right>:`   : Around 1st colon (key : value)
* `=`          : Around 1st operators with =
* `3=`         : Around 3rd operators with =
* `*=`         : Around all operators with =
* `**=`        : Left-right alternating around =
* `<Enter>=`   : Right alignment around 1st =
* `<Enter>**=` : Right-left alternating around =
* `*<C-x>[:=]` : すべての : と = を対象とする (<C-x> で正規表現使用)


Surround (feat. sandwich)
-------------------------

* `sa{TextObject}"` : TextObject を " で括る
* `sa"`             : (v) 選択範囲を " で括る
* `sai"f`           : "" 括りを、このあと入力する function と () で括る
* `sai"i`           : "" 括りを、このあと入力する head と tail で括る
* `dss`             : 一番内側の括りを外す
* `2sdd`            : 二番目に内側の括りを外す
* `sr"(`            : "" の括りを () に置き換える
* `sc"(`            : "" の括りを () に置き換える
* `sr(`             : (v) 選択した括りを () に置き換える
* `srr(`            : 一番内側の括りを () に置き換える
* `2srr(`           : 二番目に内側の括りを () に置き換える
* `rss(`            : 一番内側の括りを () に置き換える
* `css(`            : 一番内側の括りを () に置き換える
* `2css(`           : 二番目に内側の括りを () に置き換える
* `sdt`             : HTML のタグを削除


vim-emmet
---------

* `<c-y>d` / `<c-y>D` : (ni) 外側/内側 のタグの範囲を選択
* `<c-y>n` / `<c-y>N` : (ni) 次/前 の入力ポイントに移動
* `<c-y>i`            : (ni) <img> タグに移動して実行するとサイズを挿入
* `<c-y>k`            : (ni) タグの範囲を削除
* `<c-y>j`            : (ni) タグの書式をトグル <tag></tag> <--> <tag/>
* `<c-y>a`            : (ni) URL を <a> タグ化
* `<c-y>,`            : (i) 短縮入力

   1. 展開
      入力::

          div>p#foo$*3>a

      展開結果::

         <div>
             <p id="foo1">
                 <a href=""></a>
             </p>
             <p id="foo2">
                 <a href=""></a>
             </p>
             <p id="foo3">
                 <a href=""></a>
             </p>
         </div>

   2. ラップ
      入力1::

         test1
         test2
         test3

      line wise で選択して、入力2::

          ul>li*

      展開::

         <ul>
             <li>test1</li>
             <li>test2</li>
             <li>test3</li>
         </ul>

      入力2の別パターン::

          blockquote

      展開::

         <blockquote>
             test1
             test2
             test3
         </blockquote>


fold
====

* `zc` / `zo` : 現在の折りたたみを閉じる/開く
* `zC` / `zO` : 現在の折りたたみをすべて閉じる/すべて開く
* `zM` / `zR` : すべての折りたたみを閉じる/開く
* `za`        : 現在の折りたたみを開閉する
* `zv`        : カーソル位置の折りたたみをすべて開く
* `zf`        : 折りたたみを作成する


file
====

* `:DeleteMe`   : カレントファイル削除
* `:PrevimOpen` : markdown のプレビュー feat. previm


grep
====

* `<Space>*`                      : カーソルの単語をファイル内から
* `:vim {pattern} %`              : カレントバッファを
* `:vim {pattern} **`             : カレントディレクトリの全てのファイル, ディレクトリを対象に
* `:vim {pattern} *`              : カレントディレクトリの全てのファイルを対象に
* `:vim {pattern} `git ls-files`` : git の管理対象ファイルに対して
* `:grep /G \.vim$ {pattern} .`   : カレントディレクトリ配下の `*.vim` から {pattern} を検索。pt 用


vim-bookmarks
=============

* `mi` : 注釈の編集
* `mx` : ブックマークをすべて削除
* `ma` : ブックマークをすべて表示
* `mn` : 次のブックマークへ移動
* `mp` : 前のブックマークへ移動


help
====

`:help CTRL-]`             : (ノーマルモードの) コントロール文字コマンド CTRL-] のヘルプを表示
`:help i_CTRL-]`            : 挿入モードのコントロール文字コマンド CTRL-] のヘルプを表示
`:help 'number'`           : オプション number のヘルプを表示
`:help :help`              : コマンドラインコマンド help のヘルプを表示
`:helpgrep hoge`           : hoge をヘルプから検索
`:help local-additions`    : runtimepath に追加されたプラグインの doc を一覧表示
`:help highlight-groups`   : ハイライトのグループ表示
`:help cmdline-special`    : Exコマンド用の特別な文字 の説明
`:help filename-modifiers` : :p や :h などのファイル名修飾子
`<C-CR>`                   : カーソル位置のハイライト名を表示
`{nr}` 表記                : NumbeR?
`{lhs}` 表記               : Left Hand Side
`{rhs}` 表記               : Right Hand Side


QuickFix
========

* `:colder`   : 古い QuickFix へ移動
* `:cnewer`   : 新しい QuickFix へ移動
* `:chistory` : quickfix の履歴を表示


Macro
=====

* `A-m`        : マクロ m へ記録。A-m で記録を停止
* `<Space>Q a` : マクロ a へ記録。<Space>Q で記録を停止
* `@a`         : マクロ a を実行

Text Object
===========

* `ad`, `id` : /\#_-キャメルケースの文字列, で区切った文字列. feat. vim-textobj-delimited
* `av`, `iv` : _キャメルケースの文字列 変数名の区切り。キャメルケースの場合、先頭を小文字にする. feat. vim-textobj-variable-segment
* `ac`, `ic` : コメント
* `ab`, `ib` : feat. sandwich


rst
===

* `<Space><Space>n` : レベル n のセクションとして指定
* `<C-CR>`          : 現在行の List bullet を次の行に挿入
* `<S-CR>`          : 現在行の配下 List bullet を次の行に挿入
* `<C-S-CR>`        : 現在行の親 List bullet を次の行に挿入

snippet
-------

* `link_label`: `title <link>`_
* `image`: .. image:: path
* `fig`: 図にキャプションをつける場合に使用。alt の下に改行を空けて書いた内容がキャプションになる。
* `lis`: list-table
* `ref`: :ref:``
* `attention`: attention


CtrlP
=====

* `C-z` : バッファ選択
* `C-w` : バッファを閉じる


howm
========

* `<Space>,c` : howm ファイルを新規作成. feat. vim-template

golang
=======

* `]]` `[[`     : 次、前の関数へ feat. vim-go
* `:GoDecls`    : ファイル内の関数、変数の定義を CtrlP で表示 feat. vim-go
* `:GoDeclsDir` : ディレクトリ内の関数、変数の定義を CtrlP で表示 feat. vim-go
* `C-t`         : GoDef のジャンプの前の位置に戻る feat. vim-go
* `:GoFreeVars` : 選択範囲のコードで使用される変数がわかる feat. vim-go
* `<Space>ge`   : 選択したコードを続けて入力する名前で関数化 feat. godoctor.vim

ALE
====

* `<Space>al` : Lint
* `<Space>af` : Fixer
* `<Space>ak` : Next
* `<Space>aj` : Previous

Gina.vim
==========

* `<Leader>gs` : Gina status
* `cc`         : (status) Gina commit
* `s`          : (blame) Gina show

Git
========
* `<Leader>gl` : gl
* `<Leader>gd` : diff
* `<Leader>gs` : status
* `<Leader>ga` : add -p
* `<Leader>gu` : add -u
* `<Leader>gc` : commit -v
* `<Leader>gm` : commit -m
* `<Leader>gn` : now

:Gina blame の使い方
-----------------------

#. :Gina blame を起動して、Enter と BS で対象のコミットを表示
#. :Gina show でコミットの説明を参照。これをすぐに忘れるので書いておく。
#. :Gina blame で表示されるタブは :tabclose を実行したり C-q を二回押したりして閉じる。

command
-------

* `git branch -m newbranchname`: change branchname
* `git checkout -- .`: すべてのファイルの変更を stage の状態か HEAD に戻す。. の代わりにファイル名を入力すれば、そのファイルだけ
* `git checkout <hash> -- .`: すべてのファイルの変更を <hash> に戻す。. の代わりにファイル名を入力すれば、そのファイルだけ
* `git reset HEAD filename`: unstage filename
* `git pull https://github.com/{upstream/project} refs/pull/{id}/head`: フォーク元のマージされていないプルリクをマージする。via https://stackoverflow.com/questions/55108304/how-to-merge-a-pull-request-or-commit-from-a-different-repository-using-git

stash
~~~~~

* `git stash save "comment"`: stash
* `git stash list`: list stash
* `git stash show stash@{N}`: list file N's stash
* `git stash show -p stash@{N}`: show diff N's stash
* `git stash pop stash@{N}`: apply and delte N's stash
* `git stash apply stash@{N}`: apply N's stash
* `git stash drop stash@{N}`: delete N's stash

Others
======

* `<C-CR>`                  : カーソル位置のハイライトグループ名表示
* `gv`                      : 前回の選択範囲を再度選択
* `:verbose inoremap <C-l>` : <C-l> を最後に inoremap したファイルを表示
* `:verbose set whichwrap`  : whichwarp を最後に変更したファイルを表示
* `:cq`                     : vim を不正終了。git コミットのキャンセルなど
* `:Jq .obj`                : JSON の obj を抽出。引数なしなら整形のみ
* `:Jj obj`                 : JSON の obj を抽出。引数なしなら整形のみ（Jq より高速。まだ若いのでバグがあるかも）
* `/[\u3041-\u3096]`        : ひらがな検索 https://so-zou.jp/software/tech/programming/tech/regular-expression/meta-character/variable-width-encoding.htm
* `vim --clean -u vimrcfile`: Clean な Vim で vimrcfile を vimrc の代わりに読み込む
* `nnoremap [hoge] <Nop>`
  `nmap C-t [hoge]`         : [hoge] をマッピングのプレフィクス（？）にする。C-t は例。
* `<Space>rw`               : window resize mode(?) feat. submode
* `gvim -c "profile start profile.log" -c "profile func *" -c "call timer_start(0, {->execute('quit')})"` : profile の取り方
* `/[^\x01-\x7E]`           : 全角文字検索


関数エラーからの Vim script の追い方
------------------------------------

以下のようなエラーが表示された場合に関数を指定してコードを確認する。::

   function gista#autocmd#call[14]..<SNR>159_on_BufWriteCmd[13]..gista#command#patch#call[14]..gista#resource#remote#patch[17]..gista#resource#remote#get[19]..159[9]..157[34]..<SNR>137_request[33]..166 の処理中にエラーが検出されました:
   行   94:
   E887: このコマンドは無効です,ごめんなさい. Python の site モジュールをロードできませんでした.

* `:verbose function gista#autocmd#call`
* `:verbose function {157}`

powershell
----------

* `Compare-Object (Get-Content fileA) (Get-Content fileB)` | Out-File -filepath diff.txt -width 4000 -Encoding UTF8: Output diff.txt to diff fileA fileB. =>: 右ファイルからなくなった行, <=: 左ファイルからなくなった行
* `man commandlet` : ヘルプ表示。 -online: Web ブラウザで表示, alias: Get-Help, help
* `Get-Content file`: ファイルの表示。 alias: cat, type
* `New-Item -type file $profile`: PowerShell 設定ファイル作成

該当するautocommandは存在しません を調べる
-------------------------------------------

set verbose=3 するとsourceしてるものが出る

