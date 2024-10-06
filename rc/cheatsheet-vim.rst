Movement
--------

* `[z` `]z`    : 現在の折りたたみの先頭/末尾へ移動
* `zj` `zk`    : 次/前の折りたたみの先頭/末尾へ移動。feat. submode 連続して j, k 入力で次、前へ移動
* `gt` `gT`    : 前の／次のタブを表示。feat. submode 連続して t, T 入力で次、前へ移動
* `g;` `g,`    : 変更した位置への移動。feat. submode 連続して ;, , 入力で次、前へ移動
* `:jumps`     : ジャンプの履歴表示
* `C-I`        : ジャンプの履歴を進む
* `o`          : (v) 範囲開始指定をやり直し
* `<Space>;`   : 直前の f, F, t, F を繰り返す。 feat. easymotion
* `<Space>,`   : 直前の f, F, t, F を逆方向に繰り返す。 feat. easymotion
* `<C-w><C-]>` : ウィンドウを分割してタグにジャンプ
* `mv -> something -> \`v` : <C-]> や grep などの前にマークして戻れるようにする。v は mv などのマッピングがなければ他のアルファベットでも良い。


Select
-------

* `gv` : 最後に使用したのと同じ範囲を選択してのビジュアルモードを開始する
* `gp` : 最後に Put したのと同じ範囲を選択してのビジュアルモードを開始する


Edit
----

* `F6`                      : (ni) 日付の入力
* `~`                       : 大文字小文字入れ替え
* `:ISetting[!] [st][0-9]`  : インデントの変更。s2 なら space で幅2 に変更。! 付きなら Retab も実行
* `:ExpandSerialNumber`     : hoge [100-120] fuga などと入力して実行すると、hoge 100 fuga, hoge 101 fuga が各行に展開される。 feat. ExpandSerialNumber
                            : [0xa-0xf] 入力後に実行すると a-f を各行に展開 feat. ExpandSerialNumber
* `:SortLine`               : 行全体で , 区切りの文字列をソートする
* `<Space>a` / `<Space>x`   : (v) 選択範囲をインクリメント / デクリメント
* `:vim // %`               : 直前の検索条件を含む行のみを Quickfix へ出力
* `:s/hoge.*/& @fuga`       : hoge.* の後ろに @fuga を追加。& の説明は :h sub-replace-special 参照。
* `:s//bar/`                : 直前の / 検索の合致内容を bar に置換する。
* `:g/hoge/cmd`             : hoge を含む行に対して :cmd を実行。例: `:g/^function/normal A abort` functionを含む行の末尾に abort を追加。
* `:g/hoge/d`               : hoge を含む行を削除
* `/\v\<\/?\w+>`            : タグを含む行を検索
* `:g//d`                     その行を削除
* `:g/hoge/normal 1dj`      : hoge を含む行+1行を削除
* `:g/Second/s/bar/foo/g`   : Second を含む行に存在する bar をすべて foo に置換する。
* `<Space>Qa<Space>Q`       : レジスタ a を初期化
  `:g/TODO/yank A`            レジスタ a にTODOを含む行を追記
* `:Capture g/hoge/p`       : hoge を含む行のみを Capture バッファへ出力。 feat. Capture
* `:v/hoge/d` `:g!/hoge/d`  : hoge を含む行のみを残して削除。v は invert の v。
* `:v/\(^.*$\)\n\1$/delete` : ソート済みの重複行を一行のみ残して削除。重複行が3行以上ある場合は、その1行だけ削除。
* `gs`                      : 要素の移動を可能にする swap mode (j, k: 対象選択、h, l: 対称移動、s, S: ソート昇順、降順、r: 反転、g, G: グループ化、解除) に入る。. で繰り返し可能 feat. swap
* `g>`                      : 要素を右に移動 feat. swap
* `g<`                      : 要素を左に移動 feat. swap
* `gss<ESC>`                : (v) 選択範囲をソート。ノーマルモードなら一行全体。 feat. swap
* `g<C-a>`                  : (v) 選択範囲の数値を漸増的に N ずつ増やす。最初の行の数値から増加する。
* `cxiw`                    : 入れ替えたい単語で実行することで入れ替えができる。 feat. vim-exchange
* `cxc`                     : 入れ替え候補のキャンセル feat. vim-exchange
* `X`                       : (v) 入れ替えたい単語で実行することで入れ替えができる。 feat. vim-exchange
* `cxx`                     : (v) X で選択した行と、これを実行した行を入れ替え。 feat. vim-exchange
* `#`                       : (n: カーソル下の単語|v: 選択文字列) を置換。 feat. vim-asterisk
* `^M などの入力`           : vim --clean filename で起動。Insert mode で Ctrl+v Ctrl+m など
* `<C-R>"`                  : (i) 直前の無名レジスタから Put
* `<C-R>0`                  : (i) 直前の Yank のレジスタから Put。cw<C-R>" だと変更前の単語が Put されるので、こちらを使う。
* `sdt`                     : HTML のタグだけを削除。 feat. sandwich
* `dNib`                    : ("(fo|o)") | にカーソルがある時に N=2 なら (foo) が、N=3なら "(foo)" が削除できる。 feat.sandwich
* `/foo\C`                  : 小文字の foo だけにマッチ。
* `ciwhoge<C-R><C-P>"fuga`  : カーソル文字列をhogeとfugaで囲む。. で別の文字列でも同様に動作する。<C-P>がないと . では最初のカーソル文字が使われる。 https://twitter.com/mattn_jp/status/1088746858933940224
                              sandwich.vim を使う場合は、 saiwihoge<CR>fuga<CR>
* `<C-r><C-w>`              : (c) コマンドラインモードでカーソル位置の word を入力する。 <C-r><C-W> なら WORD
* `/\V`                     : 入力したままを検索
* `/<the>`                  : 単語の境界を指定して検索。the にマッチして then にマッチしない。
* `/lang/e`                 : /e でマッチの末尾にカーソル移動。auage で language にできる。その後、 n. で繰り返せる。searchx を使っているので <Space>n. か。実践Vim TIP83
* `gUgn`                    : 直前のマッチのテキストオブジェクト gn を使って、マッチした範囲を大文字へ。実践Vim TIP84
* `%s/<C-r>//"\1"/g`        : <C-r>/ 直前のマッチを挿入。実践Vim TIP90
* `%s//<C-r>0/g`            : <C-r>0 ヤンクした内容で置換。値渡し。実践Vim TIP91
* `%s//\=@0/g`              : <C-r>0 ヤンクした内容で置換。参照渡し。あんまり有用じゃないかも。実践Vim TIP91
* `%s//~/&`                 : 直前の置換を繰り返し。%を忘れた場合にこれを追加するなど。実践Vim TIP92
* `g&`                      : ファイル全体に直前の置換を繰り返し。実践Vim TIP92
* `/\v^([^,]*),([^,]*),([^,]*)$`
  `:%s//\3,\2,\1`           : hoge, fuga, homu を homu, fuga, hoge へ置換。実践Vim TIP93
* `/\v\<\/?h\zs\d`          : <h2>hoge</h2>\n<h3>fuga</h3> を <h1>hoge</h1>\n<h2>fuga</h2> に置換
  `:%s//\=submatch(0)-1/g`    \zs\d で h2 の 2 などにマッチ。\=submatch(0)-1 でマッチした 2 から -1
                              実践Vim TIP94
* `/\v(<man>|<dog>)`
  `:%s//\={"dog":"man", "man":"dog"}[submatch(1)]/g`
                            : dog と man を入れ替え。実践Vim TIP95
* `/Pragmatic/ze Vim`       : 実践Vim TIP96
  `:vimgrep /<C-r>// **/*.txt`
  `:Qargs`                    quickfix を args へ代入。 nelstorm/vim-qargs を使用
  `:argdo %s//Practical/g`    Pragmatic Vim を Practical Vim へ置換。
  `:argdo update`             保存
* `vi{`                     : {} の範囲を選択
  `:'<,'>sort`                {} の範囲の行をソート。実践Vim TIP100
* `:g/{/ .+1,/}/-1 sort`    : 複数ある {} の範囲すべての行をソート
                              { にマッチした次の行から (/{/ .+1) } にマッチした前の行までを sort。実践Vim TIP100
* `:g/{/ .+1,/}/-1 >`       : 複数ある {} の範囲すべての行をインデント
* ``

複数ファイルに対する処理
~~~~~~~~~~~~~~~~~~~~~~~~

* `:args {argument}`               : {argument} で処理対象のファイルリストを指定。{argument} は `./*.html` とか。
* `:argsadd {argument}`            : 処理対象を追加したい場合。{argument} に追加対象を指定。
* `:argdo %s/hoge/fuga/g | update` : args で指定した対象に対して置換、保存が実行される
* `:vim foo ##`                    : args で指定した対象に対して foo を実行する。## が {argument} に置換される

対象の文字列を含むファイルを全置換する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

参考: `編集を加速するVimのquickfix機能 - daisuzu's notes <https://daisuzu.hatenablog.com/entry/2020/12/03/003629>`_

1. `:enew`: 新しいバッファを開く
2. `:r !pt -l hogefuga .`: バッファに hogefuga を含むファイルのファイル名を一覧表示
3. 各行の末尾に :1:a を追加。quickfix でファイルを開けるようにするため
4. `:cbuffer` バッファの内容を quickfix に読み込み
5. `<Space>Qa`: @a へマクロの記録開始
5. `:%s/hogefuga/fugafuga/g`: 置換
6. `:w`: 保存
7. `:cnext`: 次のバッファを表示
8. `<Space>Q`: マクロの保存
9. `100@a`: ファイルの数だけマクロを繰り返し実行

. で連続して置換
~~~~~~~~~~~~~~~~~

1. / で検索
2. cgn で次の合致文字列を変更
3. . で次の合致文字列を同様に置換


Easy Align
~~~~~~~~~~

* `<Space>`    : Around 1st whitespaces
* `2<Space>`   : Around 2nd whitespaces
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
~~~~~~~~~~~~~~~~~~~~~~~~~

* `sa{Text Object}"`: Text Object を " で括る
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
~~~~~~~~~

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
----

* `zc` / `zo` : 現在の折りたたみを閉じる/開く
* `zC` / `zO` : 現在の折りたたみをすべて閉じる/すべて開く
* `zM` / `zR` : すべての折りたたみを閉じる/開く
* `za`        : 現在の折りたたみを開閉する
* `zv`        : カーソル位置の折りたたみをすべて開く
* `zf`        : 折りたたみを作成する
* `:set nofen`: 折り畳みの無効化。statusline で fold が有効になっていると意図しないタイミングで折りたたまれることがあるので無効にする。
* `C-q`       : (i) ターミナルコードの入力


file
----

* `:PrevimOpen` : markdown のプレビュー feat. previm


grep
----

* `<Space>*`                        : カーソルの単語をファイル内から検索指定 Quickfix へ表示
* `:vim /{pattern}/ %`              : カレントバッファを
* `:vim /{pattern}/ **`             : カレントディレクトリの全てのファイル, ディレクトリを対象に。**/* じゃない？
* `:vim /{pattern}/ *`              : カレントディレクトリの全てのファイルを対象に
* `:vim /{pattern}/ `git ls-files`` : git の管理対象ファイルに対して
* `:grep /G \.vim$ {pattern} .`     : カレントディレクトリ配下の `*.vim` から {pattern} を検索。pt 用


help
----

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
`{lhs}` 表記               : Left Hand Side 左辺値
`{rhs}` 表記               : Right Hand Side 右辺値
`:help index.txt`          : 各モードのデフォルトキーマップを表示
`:h 02.8`                  : ヘルプの引き方


quickfix
--------

* `:cwindow`   : quickfix の表示
* `:colder`    : 古い quickfix へ移動
* `:cnewer`    : 新しい quickfix へ移動
* `:chistory`  : quickfix の履歴を表示
* `:4chistory` : 4番目の quickfix リストをカレントリストにする
* `p`          : (quickfixi) quickfix のプレビューをトグル. feat. quickpeek.vim


Macro
-----

* `A-m`             : マクロ m へ記録。A-m で記録を停止。
* `<Space>Qa`       : マクロ a へ記録。<Space>Q で記録を停止
* `<Space>QA`       : マクロ a へ追加記録する。<Space>Q で記録を停止
* `@a`              : マクロ a を実行
* `@@`              : 直前のマクロを再実行。
* `:'<,'>normal @a` : 選択範囲でマクロ a を実行。


複数のファイルでマクロを実行する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. | マクロを適用するファイルのリストを作成する
   | `:args .rb`
#. | 引数リストの先頭に移動
   | `:first`
#. マクロ a に記録
#. マクロの実行

  a. 並列に実行

    A. | マクロの登録に使った変更済みのファイルを元に戻す
       | `:edit!`
    B. | 引数リストのすべてのファイルでマクロを実行
       | `argdo normal @a`

  b. 直列に実行

    A. | マクロ a に追記。:next が失敗すれば止まるので十分な回数（22）繰り返す
       | `<Space>QA`
       | `:next`
       | `<Space>Q`
       | `22@a`

#. | ファイルの保存
   | `:argdo write` or `:wall`


スクリプトを使ったマクロ
~~~~~~~~~~~~~~~~~~~~~~~~

a    1) a
b -> 2) b
c    3) c

#. 一行目でマクロを記録

  #. `:let i=1`
  #. `<Space>Qa`
  #. `I<C-r>=i<CR> <Esc>`
  #. `:let i+=1`
  #. `<Space>Q`

#. | 二行目以降を選択して
   | `:'<,'>normal @a


マクロの内容を編集する
~~~~~~~~~~~~~~~~~~~~~~

#. | マクロ a をバッファに出力する
   | `:put a`
#. 必要な変更を加える
#. | マクロ a へヤンク。末尾の改行を含めないように `"add` は使わない。
   | `0`, `"ay$`


thinca の教え
~~~~~~~~~~~~~

例えば q をマクロで使う場合、マクロの最後に @q を入れます。
（あらかじめ qq -> q で q のマクロを空にしておく）
そうすると同じマクロが再度再生され、エラーが出るまで実行され続けます。
これは例えばマクロを適用したい場所を検索しておいて、`n@qn@q` とやる代わりに
マクロの最後を n@q にしておけば 1 度の実行で自動的に全部の箇所に順次適用される感じです
(最後は検索でジャンプできずに止まる。適用後のテキストも検索で引っかかってしまうとずっと止まらないので注意)


Text Object
-----------

* `ad`, `id` : /\#_-キャメルケースの文字列で区切った文字列. feat. vim-textobj-delimited
* `ac`, `ic` : コメント
* `ab`, `ib` : feat. sandwich
* `a,`, `i,` : , 区切りの要素。feat. swap


rst
---

* `<Space><Space>n` : レベル n のセクションとして指定
* `<C-CR>`          : 現在行の List bullet を次の行に挿入
* `<S-CR>`          : 現在行の配下 List bullet を次の行に挿入
* `<C-S-CR>`        : 現在行の親 List bullet を次の行に挿入


snippet
~~~~~~~

* `link_label`: `title <link>`_
* `image`: .. image:: path
* `fig`: 図にキャプションをつける場合に使用。alt の下に改行を空けて書いた内容がキャプションになる。
* `lis`: list-table
* `ref`: :ref:``
* `attention`: attention


CtrlP
-----

* `C-z` : バッファ選択
* `C-w` : バッファを閉じる


howm
----

* `<Space>,c` : howm ファイルを新規作成. feat. vim-template

golang
------

* `GoRun`          : feat. vim-gorun
* `GoAddTags json` : struct に json tag を追加。feat. vim-goaddtags

LSP
---

* `<Space>al` : Show diagnostics list in quickfix. feat. vim-lsp
* `<Space>ak` : Next diagnostics. feat. vim-lsp
* `<Space>aj` : Previous diagnostics. feat. vim-lsp

Git
---

keymap
~~~~~~

* `<Space>gl`  : graph log
* `<Space>gL`  : graph log 100 line in Gina. feat. gina.vim
* `<Space>gd`  : diff
* `<Space>gs`  : status
* `<Space>gS`  : status in Gina. feat. gina.vim
* `<Space>gg`  : log -p -G"|"
* `<Space>ga`  : add -p in popup window
* `<Space>gu`  : add all tracking files
* `<Space>gc`  : commit -v
* `<Space>gm`  : Show the history of commits under the cursor. feat. git-messenger.vim
* `<Space>gn`  : commit -a -m "|"
* `<Space>gbb` : Show branches
* `<Space>gbr` : Rename current branch
* `<Space>gbl` : blame in Gina. feat. gina.vim
* `<Space>g-`  : Switch last commit and new branch name

Vim で commit のやりなおし
~~~~~~~~~~~~~~~~~~~~~~~~~~

* `<Space>gbr (git branch -m temp)`: 現在のブランチ名を temp へ変更。
* `<Space>g- (git switch -c master HEAD~)`: 一つ前のコミットのブランチ名を master にする。
* `<Space>gr (git restore -s temp .)`: すべてのファイルを temp ブランチの内容に変更。ステージングはされていない状態。
* コミットやり直し。
* `<Space>gbd (git branch -D temp)`: temp ブランチ削除

gina.vim
~~~~~~~~

* `cc`          : (status) Gina commit
* `s`           : (blame) Gina show
* `:Gina log :` : current buffer history

:Gina blame の使い方
~~~~~~~~~~~~~~~~~~~~~~~

#. :Gina blame を起動して、Enter と BS で対象のコミットを表示
#. :Gina show でコミットの説明を参照。これをすぐに忘れるので書いておく。
#. :Gina blame で表示されるタブは :tabclose を実行したり C-q を2回押したりして閉じる。

Gina patch, GinPatch
~~~~~~~~~~~~~~~~~~~~

左: 元、中央: 反映、右: worktree で表示。
コミットしたい内容へ中央のバッファを変更して :w
:Gin commit -v でコミット

* `dp`: 左か右のバッファで実行して中央へ反映
* `dor`: 中央のバッファで実行して右の内容を反映
* `dol`: 中央のバッファで実行して左の内容を反映

Others
------

* `<M-i>`                   : (c) コマンドラインウィンドウ表示
* `<C-CR>`                  : カーソル位置のハイライトグループ名表示
* `gv`                      : 前回の選択範囲を再度選択
* `:verbose inoremap <C-l>` : <C-l> を最後に inoremap したファイルを表示
* `:verbose set whichwrap`  : whichwarp を最後に変更したファイルを表示
* `:cq`                     : vim を不正終了。git コミットのキャンセルなど
* `:Jq .obj`                : JSON の obj を抽出。引数なしなら整形のみ
* `/[\u3041-\u3096]`        : ひらがな検索 https://so-zou.jp/software/tech/programming/tech/regular-expression/meta-character/variable-width-encoding.htm
* `vim --clean -u vimrcfile`: Clean な Vim で vimrcfile を vimrc の代わりに読み込む
* `nnoremap [hoge] <Nop>`
  `nmap C-t [hoge]`         : [hoge] をマッピングのプレフィクス（？）にする。C-t は例。
* `<Space>rw`               : window resize mode(?) feat. submode
* `/[^\x01-\x7E]`           : 全角文字検索
* `<Space>y%`               : バッファのファイル名をクリップボードへコピー
* `:set nomodeline`         : " vim:fen などのモードラインがファイルに記載されていても、これを反映しない。vim-lsp ポップアップ時に fen が反映されることがあったので
* `@:`                      : 直前に実行した `:` コマンドを再実行。
* `let &l:statusline='hoge'`: setlocal statusline の let 版。ほかのオプションも同様。


起動時の profile の取り方
~~~~~~~~~~~~~~~~~~~~~~~~~

`gvim -c "profile start profile.log" -c "profile func *" -c "call timer_start(0, {->execute('quit')})"`


気になる関数の profile の取り方
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

コマンド定義 ::

   command! -nargs=* Profile call s:command_profile('<args>')
   function s:command_profile(section) abort
     profile start ~/profile.txt
     profile func *
     execute printf('profile file %s', empty(a:section) ? '*' : a:section)
   endfunction

1. `:Profile hogefunc` を実行する
2. profile.txt の中身を確認


気になる操作の profile の取り方
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

コマンド定義 ::

   command! Profile call s:command_profile()
   function s:command_profile() abort
     profile start ~/profile.txt
     profile func *
     profile file *
   endfunction

1. vim を立ち上げ直す
2. `:Profile` を実行する
3. 気になっている操作を実行する
4. vim を落とす
5. profile.txt の中身を確認


関数エラーからの Vim script の追い方
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

以下のようなエラーが表示された場合に関数を指定してコードを確認する。::

   function gista#autocmd#call[14]..<SNR>159_on_BufWriteCmd[13]..gista#command#patch#call[14]..gista#resource#remote#patch[17]..gista#resource#remote#get[19]..159[9]..157[34]..<SNR>137_request[33]..166 の処理中にエラーが検出されました:
   行   94:
   E887: このコマンドは無効です,ごめんなさい. Python の site モジュールをロードできませんでした.

* `:verbose function gista#autocmd#call`
* `:verbose function {157}`


該当するautocommandは存在しません を調べる
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set verbose=3 するとsourceしてるものが出る


デバッグプリント
~~~~~~~~~~~~~~~~

* `:Capture PP dict`: 整形して表示してくれる。
* `:Capture verbose PP dict`: 辞書関数の中身も見られる。
* `:echom string(dict)` : echom に副作用があるらしい。知らんけど。
* `:put=string(dict)` : バッファに出力。
* `:let g:x=dict` : からの `:breakadd expr g:x` ？　よくわからん。


デバッグログ
~~~~~~~~~~~~

`vim -V9log.log`: log.log に色々表示。


現在の選択範囲を取得
~~~~~~~~~~~~~~~~~~~~

現在の選択範囲を取得::

  function s:get_current_selection() abort
    if mode() !~# '^[vV\x16]'
      " not in visual mode
      return ''
    endif

    " save current z register
    let save_reg = getreginfo('z')

    " get selection through z register
    noautocmd normal! "zygv
    let result = @z

    " restore z register
    call setreg('z', save_reg)

    return result
  endfunction


サブモードの定義
~~~~~~~~~~~~~~~~

https://vim-jp.slack.com/archives/CJMV3MSLR/p1702391608879069
atusy 2023-12-12 23:32

gttt::

  nnoremap gt gt<Plug>(gt)
  nnoremap gT gT<Plug>(gt)
  nnoremap <Plug>(gt)t gt<Plug>(gt)
  nnoremap <Plug>(gt)T gT<Plug>(gt)


ddu で 現在ディレクトリが git repository だったら git を そうでないならば rg を実行
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

  function! s:ddu_grep() abort
      if system('git rev-parse --is-inside-work-tree') == "true\n"
          let l:cmd = 'git'
          let l:args = ['--no-pager', 'grep', '--line-number', '--column', '--no-color']
      else
          let l:cmd = 'rg'
          let l:args = ["--column", "--no-heading", "--color", "never"]
      endif
  
      call ddu#start(#{
                  \ sources: ['rg'],
                  \ sourceParams: #{
                  \   rg: #{
                  \     cmd: l:cmd,
                  \     args: l:args,
                  \     input: input('Pattern: ')
                  \   },
                  \ },
                  \ })
  endfunction
  nnoremap <silent> <Leader>fg <Cmd>call <SID>ddu_grep()<CR>

一度検索して確認したのち、操作を実施。
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Vim で始める正規表現 Vim Advent Calendar 2023 25日目 | Medium" https://satorunooshie.medium.com/vim-with-regexp-7baa93d1205c

検索後にマッチする行を削除::

  /^[:space:]*$
  :g//d


正規表現
--------

* `[^[:keyword:]]\zs(` : (の前にキーワードなし。\zs で ( にカーソルを合わせている。

\zs を使った . の例
~~~~~~~~~~~~~~~~~~~

https://twitter.com/mattn_jp/status/1734791816829116481

/value: 1$
で検索できることを確認した後に
/value: \zs1$
で検索するとカーソル位置 1 の前に来るので
検索したあと cw2 みたいに変更した後に
n.n.n.n. とか出来る。

