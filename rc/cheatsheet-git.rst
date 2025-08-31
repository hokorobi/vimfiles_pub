command
-------

* `git branch -m newbranchname`: 現在のブランチ名を branchname に変更
* `git switch -c newbranchname`: newbranchname を作ってブランチを切り替える
* `git switch -`: 一つ前のブランチに戻る
* `git pull https://github.com/{upstream/project} refs/pull/{id}/head`: フォーク元のマージされていないプルリク PR をマージする。
  via https://stackoverflow.com/questions/55108304/how-to-merge-a-pull-request-or-commit-from-a-different-repository-using-git
* `git fetch origin pull/ID/head:BRANCHNAME`: マージされていないプルリク #ID を試す。
* `git log -G"hoge" -p`: 履歴の差分から hoge を検索する。 --pickaxe-all も指定すると、検索されたコミットで変更のあったファイルすべてを表示する。
* `git submodule update --remote` : 配下の submodule を更新
* `git clone --depth=1 URL` : 最新のコミットだけをクローン
* `git branch -r` : リモートブランチ表示
* `git pull org master:master` : ローカルの master ブランチへ org/master から pull
* `git fetch --all --prune`: リモートでMergeされて削除されたブランチをローカルに反映させて消す。origin/* とかが消えて、ローカルブランチが消えるわけではない。
* `git cherry-pick AコミットID^..EコミットID`: AコミットID から EコミットID を cherry-pick。 https://dev.classmethod.jp/articles/git-cherry-pick-pitfall/
* `git checkout 'master@{1979-02-26 18:30:00}'`: 指定した日時の時点をチェックアウト。


戻す
----

* `git restore -s ${HASH} .`: すべてのファイルを ${HASH} の内容に戻す。ステージングはされていない状態。
* `git restore filename`: ステージングされていないファイルを直前のコミットの状態に戻す。
* `git reset filename`: add した filename を取り消す。内容は変えない。filename が . ならすべてが対象。
* `git restore --staged filename`: add した filename を取り消す。内容は変えない。filename が . ならすべてが対象。
* `git add -i`: revert で add したものを元に戻せる。Vimからだとうまく動かないことが多い。
* `git reset --hard ORIG_HEAD`: マージコミット後に元に戻す。


GitHub で clone したリポジトリに追従する
----------------------------------------

1. `git remote add upstream https://github.com/hoge/fuga`
2. `git fetch upstream`
3. `git checkout main`
4. `git merge upstream/main`
5. `git checkout hoge`
6. `git rebase main`


push した master ブランチのコミットを一つ消す
---------------------------------------------

1. `git branch -m temp`
2. `git co -b master HEAD^`
3. `git push -f origin @`
4. `git branch -D temp`


git で管理していないファイルを試しに作ってみて消す
--------------------------------------------------

やっぱり使いたいといったときに戻せる

`git stash push -u -m "comment"`


git stash
----------

* `git stash push -u -m "comment"`: stash. -u include untrack
* `git stash list`: list stash
* `git stash pop`: apply and delte 0's stash
* `git stash show stash@{N}`: list file N's stash
* `git stash show -p stash@{N}`: show diff N's stash
* `git stash pop stash@{N}`: apply and delte N's stash
* `git stash apply stash@{N}`: apply N's stash
* `git stash drop stash@{N}`: delete N's stash


別のリポジトリのブランチを登録する
----------------------------------

https://github.com/username/reponame の master ブランチを username ブランチとして登録する。

git fetch https://github.com/username/reponame master:username


別のリポジトリから cherry-pick
------------------------------

1. git remote add newremotename https://path/to/repogitory
2. git fetch newremotename
3. git cherry-pick newremotenameHash

via http://blog.atwata.com/tool/2017/02/22/git-cross-repo-cherry-pick.html


GitHub の GraphQL
-----------------

curl -H "Authorization: bearer "<token> -X POST -d@query.json https://api.github.com/graphql

query.json
{ "query": "query {a0:repository(owner:\"markonm\", name: \"traces.vim\"){ pushedAt nameWithOwner }}" }

detached HEAD
-------------

rebase -i などの後に発生。
branch <branch名> でブランチ名をつけてやれば解消。
master への付け替えは、 branch -f master のあとに switch master。

gh
---

* `gh release upload <tag> <file>`: https://cli.github.com/manual/gh_release_upload



ほか
----

コンフリクトを試すリポジトリ
https://github.com/QuinnyPig/conflicts
