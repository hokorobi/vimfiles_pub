simple align
~~~~~~~~~~~~

* SimpleAlign {DELIMITER} {OPTIONS}
  -c -1  : -c 何回splitするか。デフォルトは -1 （無制限）
  -l 1   : split の左にpaddingにいくつ入れる
  -r 1   : split の右にpaddingにいくつ入れる
  -j left: right, left どちらにそろえるか

* [^<]*<[^<]*<[^<]*\zs< -c 1 -r 0: 四つ目の<


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
