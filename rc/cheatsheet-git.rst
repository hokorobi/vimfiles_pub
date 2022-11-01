command
-------

* `git branch -m newbranchname`: change current branchname
* `git switch -c newbranchname`: newbranchname を作って切り替える
* `git switch -`: 一つ前のブランチに戻る
* `git restore -s ${HASH} .`: すべてのファイルを ${HASH} の内容に戻す。ステージングはされていない状態。
* `git restore filename`: ステージングされていないファイルを直前のコミットの状態に戻す。
* `git restore --staged filename`: Unstage filename. Unstage everything is ".".
* `git pull https://github.com/{upstream/project} refs/pull/{id}/head`: フォーク元のマージされていないプルリクをマージする。
  via https://stackoverflow.com/questions/55108304/how-to-merge-a-pull-request-or-commit-from-a-different-repository-using-git
* `git fetch origin refs/pull/head:BRANCHNAME`: マージされていないプルリクを試す。
* `git log -G"hoge" -p`: 履歴の差分から hoge を検索する。 --pickaxe-all も指定すると、検索されたコミットで変更のあったファイルすべてを表示する。
* `git submodule update --remote` : 配下の submodule を更新
* `git clone --depth=1 URL` : 最新のコミットだけをクローン
* `git branch -r` : リモートブランチ表示
* `git pull org master:master` : ローカルの master ブランチへ org/master から pull

git stash
----------

* `git stash push -u -m "comment"`: stash. -u include untrack
* `git stash list`: list stash
* `git stash show stash@{N}`: list file N's stash
* `git stash show -p stash@{N}`: show diff N's stash
* `git stash pop stash@{N}`: apply and delte N's stash
* `git stash apply stash@{N}`: apply N's stash
* `git stash drop stash@{N}`: delete N's stash


PR をマージ
-----------

#. git fetch https://github.com/prabirshrestha/asyncomplete.vim refs/pull/135/head:pr135
#. git merge pr135

* `https://github.com/prabirshrestha/asyncomplete.vim refs/pull/135` は任意の PR
* `head` で PR の最新コミットまでを対象にする
* `pr135` はブランチ名


GitHub の GraphQL
-----------------

curl -H "Authorization: bearer "<token> -X POST -d@query.json https://api.github.com/graphql

query.json
{ "query": "query {a0:repository(owner:\"markonm\", name: \"traces.vim\"){ pushedAt nameWithOwner }}" }
