ImageMagick で画像の切り抜き
============================

切り抜き。高さだけ 100% などは使えない。::

    convert -crop 切り抜く幅x高さ+開始X+開始Y input.jpg output.jpg

crop フォルダへ一括書き出し::

    mogrify -path crop -crop 切り抜く幅x高さ+開始X+開始Y *.jpg

output-0.jpg, output-1.jpg へ横分割::

    convert -crop 50%x100% input.jpg output.jpg
