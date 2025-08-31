" hook_add {{{
nnoremap ? <Cmd>call cheatsheetecho#CheatSheetEcho()<CR>
let s:tips = [
      \ 'C-i / C-o	ジャンプリストを進む/戻る',
      \ 'M-c	直前の実行コマンドの結果を Capture で表示',
      \ 'M-CR	lazy#ShowHighlightGroup() カーソル下のハイライトの情報表示',
      \ '<Space>#	カーソル下の単語、選択で置換',
      \ '<Space>*	カーソル下の単語、選択で CtrlP lines',
      \ '<Space>tt	英語に翻訳 feat Textra',
      \ ':Vista	バッファの情報をいい感じに表示 feat vista.vim',
      \ ':r9	Quickrun Vim9 script feat altercmd',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips)
let s:tips = [
      \ '<Space>gaD	gin で変更箇所単位での add',
      \ '<Space>gy	Github の URL をクリップボードにコピー',
      \ '<Space>gbb	ブランチ表示',
      \ '<Space>gbd	ブランチ削除',
      \ '<Space>gbm	ブランチリネーム',
      \ '<Space>gbr	ブランチリネーム',
      \ '<Space>g-	直前のコミットでブランチを切る',
      \ '<Space>gbo	任意のコミットのファイルを開く',
      \ '<Space>gbw	直前のブランチに戻す',
      \ '<Space>gn	メッセージを入力して変更をすべてコミット',
      \ '<Space>gN	メッセージの入寮区は Vim で変更をすべてadd',
      \ '<Space>gh	cherry-pick',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'Git')
let s:tips = [
      \ 'zc / zo	現在の折りたたみを閉じる/開く',
      \ 'zC / zO	現在の折りたたみをすべて閉じる/すべて開く',
      \ 'zM / zR	すべての折りたたみを閉じる/開く',
      \ 'za	現在の折りたたみを開閉する',
      \ 'zv	カーソル位置の折りたたみをすべて開く',
      \ 'zf	折りたたみを作成する',
      \ ':set nofen	折り畳みの無効化',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'Fold')
let s:tips = [
      \ '<C-u>	直前に入力した単語を大文字へ',
      \ '<C-r>c	c で上書きした直前の無名レジスタの内容を入力。',
      \ '<C-r>d	d で上書きした直前の無名レジスタの内容を入力。',
      \]
call cheatsheetecho#CheatSheetEchoAdd(s:tips, '_', 'Insert')
" }}}
