vim9script
scriptencoding utf-8
# Plugin Manager {{{1

dein#add('Shougo/dein.vim', {
  hooks_file: '~/vimfiles/rc/dein/ft.vim',
})
# memo
# on_source: このプラグインがリストのプラグインより先に読み込まれる
# depends: リストのプラグインがこのプラグインより先に読み込まれる
# on_cmd: 自分で定義したコマンドは登録しない。一度実行したら消えるみたい。

dein#add('hokorobi/vim-templug', {
  frozen: 1,
  on_cmd: 'Templug',
  hook_add: 'set packpath+=~/_vim',
})

# }}}1  LSP {{{1
# 遅延読込を実現しようとすると色々と大変。
dein#add('prabirshrestha/vim-lsp', {
  hooks_file: '~/vimfiles/rc/dein/lsp.vim',
})

dein#add('mattn/vim-lsp-settings', {
  depends: 'vim-lsp',
  hooks_file: '~/vimfiles/rc/dein/lsp-settings.vim',
})

dein#add('matsui54/denops-signature_help', {
  depends: 'denops.vim',
  on_func: 'signature_help#',
  hooks_file: '~/vimfiles/rc/dein/denops-signature_help.vim',
})
# }}}1  REPL {{{1

# Quickrun {{{2

dein#add('thinca/vim-quickrun', {
  on_cmd: 'QuickRun',
  depends: 'shabadou.vim',
  hooks_file: '~/vimfiles/rc/dein/quickrun.vim',
})

dein#add('osyo-manga/shabadou.vim')

# }}}2

dein#add('rhysd/reply.vim', {
  on_cmd: ['Repl', 'ReplAuto'],
})

# }}}1  Text Object {{{1

dein#add('kana/vim-textobj-user')

dein#add('mattn/vim-textobj-url', {
  depends: 'vim-textobj-user',
  on_map: {ox: ['iu', 'au']},
})

dein#add('machakann/vim-sandwich', {
  on_event: 'ModeChanged',
  hooks_file: '~/vimfiles/rc/dein/sandwich.vim',
})

dein#add('tommcdo/vim-exchange', {
  on_map: {n: 'cx', x: 'X'},
})

dein#add('kana/vim-textobj-indent', {
  depends: 'vim-textobj-user',
  on_map: {ox: ['ii', 'ai', 'iI']},
})

dein#add('glts/vim-textobj-comment', {
  on_map: {ox: ['ac', 'aC', 'ic']},
  depends: 'vim-textobj-user',
})

dein#add('romgrk/equal.operator', {
  on_map: {ox: ['<Plug>']},
  hooks_file: '~/vimfiles/rc/dein/equal.operator.vim',
})

dein#add('machakann/vim-textobj-functioncall', {
  on_map: {ox: ['<Plug>']},
  on_source: 'vim-sandwich',
  hooks_file: '~/vimfiles/rc/dein/textobj-functioncall.vim',
})

dein#add('machakann/vim-textobj-delimited', {
  on_map: {ox: ['ad', 'aD', 'id', 'iD']},
})

dein#add('kana/vim-textobj-line', {
  on_map: {ox: ['al', 'il']},
  hooks_file: '~/vimfiles/rc/dein/textobj-line.vim',
})

# }}}1  Language, Format, Filetype {{{1

# diff {{{2

dein#add('AndrewRadev/linediff.vim', {
  on_cmd: 'Linediff',
  hooks_file: '~/vimfiles/rc/dein/linediff.vim',
})

# }}}2 Python {{{2

dein#add('hdima/python-syntax', {
  hooks_file: '~/vimfiles/rc/dein/python-syntax.vim',
})

dein#add('hynek/vim-python-pep8-indent')

# }}}2 Golang {{{2

dein#add('mattn/vim-godoc')

dein#add('mattn/vim-gorun')

dein#add('mattn/vim-goaddtags')

# }}}2 Markdown {{{2

dein#add('previm/previm', {
  on_cmd: 'PrevimOpen',
  depends: 'open-browser.vim',
})

dein#add('plasticboy/vim-markdown', {
  hooks_file: '~/vimfiles/rc/dein/markdown.vim',
})

# }}}2 rst {{{2

dein#add('hokorobi/vim-rst-util', {
  frozen: 1,
  on_ft: 'rst',
  hooks_file: '~/vimfiles/rc/dein/rst-util.vim',
})

dein#add('habamax/vim-rst', {
  on_ft: 'rst',
})

# }}}2 quickfix {{{2

dein#add('lambdalisue/qfloc.vim', {
  on_ft: 'qf',
  hooks_file: '~/vimfiles/rc/dein/qfloc.vim',
})

dein#add('thinca/vim-qfreplace', {
  on_cmd: 'Qfreplace',
})

# preview Quickfix at popup
# dein#add('AndrewRadev/quickpeek.vim', {
#   on_ft: 'qf',
#   hooks_file: '~/vimfiles/rc/dein/quickpeek.vim',
# })

# preview Quickfix at popup
dein#add('bfrg/vim-qf-preview', {
  on_ft: 'qf',
  hooks_file: '~/vimfiles/rc/dein/qf-preview.vim',
})

dein#add('mattn/vim-qfnavigate', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/qfnavigate.vim',
})

# QuickFixでジャンプするときに直前のWindowを使う
dein#add('yssl/QFEnter', {
  on_ft: 'qf',
})

dein#add('bfrg/vim-qf-history', {
  on_cmd: ['Chistory', 'Lhistory'],
  hooks_file: '~/vimfiles/rc/dein/qf-history.vim',
})

# }}}2 Vim {{{2

dein#add('vim-jp/syntax-vim-ex')

# Vim script の最後に発生したエラーの箇所を開く
dein#add('rbtnn/vim-vimscript_lasterror', {
  on_cmd: 'VimscriptLastError',
})

dein#add('rbtnn/vim-vimscript_tagfunc', {
  on_ft: 'vim',
})

dein#add('rbtnn/vim-vimscript_indentexpr', {
  on_ft: 'vim',
})

# }}}2 Others {{{2

dein#add('pangloss/vim-javascript')

dein#add('weirongxu/plantuml-previewer.vim', {
  depends: 'open-browser.vim',
  on_cmd: 'PlantumlOpen',
  hooks_file: '~/vimfiles/rc/dein/plantuml-previewer.vim',
})

dein#add('hokorobi/plantuml-syntax', {
  # rev: 'dev',
  frozen: 1,
  merged: 0,
})

dein#add('hnamikaw/vim-autohotkey')

dein#add('mechatroner/rainbow_csv', {
  on_cmd: 'RainbowDelim',
})

#
# dein#add('mattn/emmet-vim', {
#   on_ft: 'html'

dein#add('hokorobi/vim-howm-syntax-mini', {
  frozen: 1,
})

# dein#add('alvan/vim-closetag', {
#   on_ft: ['html', 'xml'],
# })

#}}}2

# }}}1  Look {{{1

dein#add('rhysd/vim-color-spring-night', {
  hooks_file: '~/vimfiles/rc/dein/color-spring-night.vim',
})

# インクリメンタルサーチの件数をポップアップ表示
dein#add('obcat/vim-hitspop', {
  on_event: 'CmdlineEnter',
  hooks_file: '~/vimfiles/rc/dein/hitspop.vim',
})

dein#add('itchyny/lightline.vim', {
  depends: 'vim-color-spring-night',
  hooks_file: '~/vimfiles/rc/dein/lightline.vim',
})

dein#add('itchyny/vim-cursorword')

# replace matchparen
dein#add('andymass/vim-matchup', {
  hooks_file: '~/vimfiles/rc/dein/matchup.vim',
})

dein#add('t9md/vim-quickhl', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/quickhl.vim',
})

# :substitute などで変更対象のハイライト、変更後のプレビュー
dein#add('markonm/traces.vim', {
  on_event: 'CmdlineEnter',
  hooks_file: '~/vimfiles/rc/dein/traces.vim',
})

dein#add('liuchengxu/vista.vim', {
  on_cmd: 'Vista',
  hooks_file: '~/vimfiles/rc/dein/vista.vim',
})

dein#add('lambdalisue/readablefold.vim')

# #rrggbb や #rgb の色を視覚化
dein#add('BourgeoisBear/clrzr', {
  on_cmd: 'ClrzrOn',
  hooks_file: '~/vimfiles/rc/dein/clrzr.vim',
})

dein#add('machakann/vim-highlightedyank', {
  hooks_file: '~/vimfiles/rc/dein/highlightedyank.vim',
})

dein#add('rbtnn/vim-ambiwidth', {
  hooks_file: '~/vimfiles/rc/dein/ambiwidth.vim',
})

dein#add('wellle/context.vim', {
})

# }}}1  Input & Edit {{{1

dein#add('cohama/lexima.vim', {
  on_event: ['InsertEnter', 'CmdlineEnter'],
  hooks_file: '~/vimfiles/rc/dein/lexima.vim',
})

# https://scrapbox.io/vim-jp/lexima.vim%E3%81%A7Better_vim-altercmd%E3%82%92%E5%86%8D%E7%8F%BE%E3%81%99%E3%82%8B
dein#add('yuki-yano/lexima-alter-command.vim', {
  on_event: ['CmdlineEnter'],
  depends: 'lexima.vim',
  hooks_file: '~/vimfiles/rc/dein/lexima-alter-command.vim',
})

dein#add('thinca/vim-ambicmd', {
  on_event: ['CmdlineEnter'],
  depends: 'lexima.vim',
  hooks_file: '~/vimfiles/rc/dein/ambicmd.vim',
})

dein#add('uplus/vim-clurin', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/clurin.vim',
})

dein#add('junegunn/vim-easy-align', {
  on_cmd: 'EasyAlign',
  on_map: '<Plug>(EasyAlign',
  hooks_file: '~/vimfiles/rc/dein/easy-align.vim',
})

dein#add('mbbill/undotree', {
  on_cmd: 'UndotreeToggle',
  hooks_file: '~/vimfiles/rc/dein/undotree.vim',
})

dein#add('osyo-manga/vim-jplus', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/jplus.vim',
})

dein#add('hokorobi/yankround.vim', {
  on_cmd: 'CtrlPYankRound',
  hooks_file: '~/vimfiles/rc/dein/yankround.vim',
})

# g<C-a> などは同行での連番はできないようなので、まだ有用
dein#add('deris/vim-rengbang', {
  on_cmd: ['RengBang', 'RengBangUsePrev', 'RengBangConfirm'],
  hooks_file: '~/vimfiles/rc/dein/rengbang.vim',
})

dein#add('ntpeters/vim-better-whitespace', {
  on_cmd: ['StripWhitespace', 'ToggleStripWhitespaceOnSave'],
  hooks_file: '~/vimfiles/rc/dein/better-whitespace.vim',
})

dein#add('mattn/vim-sonictemplate', {
  on_cmd: 'Template',
  on_map: {ni: '<C-y>'},
  hooks_file: '~/vimfiles/rc/dein/sonictemplate.vim',
})

dein#add('deris/vim-pasta', {
  on_map: {nx: ['<Space>p', '<Space>P']},
  hooks_file: '~/vimfiles/rc/dein/pasta.vim',
})

dein#add('nocd5/ExpandSerialNumber.vim', {
  on_cmd: 'ExpandSerialNumber',
})

dein#add('lambdalisue/vim-findent', {
  on_cmd: ['Findent', 'FindentRestore'],
  hooks_file: '~/vimfiles/rc/dein/findent.vim',
})

dein#add('machakann/vim-swap', {
  on_map: {ox: ['<Plug>'], n: ['gs', 'g<', 'g>']},
  hooks_file: '~/vimfiles/rc/dein/swap.vim',
})

# 選択した行すべてに対して I, A を反映させる。
dein#add('kana/vim-niceblock', {
  on_map: {x: ['I', 'gI', 'A']},
})

dein#add('tyru/caw.vim', {
  depends: 'vim-repeat',
  on_map: '<Plug>(caw:prefix)',
  hooks_file: '~/vimfiles/rc/dein/caw.vim',
})

dein#add('kana/vim-repeat', {
  lazy: 1,
})

dein#add('matze/vim-move', {
  on_map: '<Plug>Move',
  hooks_file: '~/vimfiles/rc/dein/move.vim',
})

dein#add('sentriz/vim-print-debug', {
  on_func: 'print_debug#print_debug',
  hooks_file: '~/vimfiles/rc/dein/print-debug.vim',
})

# }}}1  Motion {{{1

dein#add('easymotion/vim-easymotion', {
  on_map: {nxo: '<Plug>'},
  hooks_file: '~/vimfiles/rc/dein/easymotion.vim',
})

dein#add('haya14busa/vim-edgemotion', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/edgemotion.vim',
})

dein#add('haya14busa/vim-asterisk', {
  on_map: '<Plug>',
  hooks_file: '~/vimfiles/rc/dein/asterisk.vim',
})

dein#add('hrsh7th/vim-searchx', {
  on_func: 'searchx#run',
  hooks_file: '~/vimfiles/rc/dein/searchx.vim',
})

# カーソル移動位置を遡る
dein#add('osyo-manga/vim-milfeulle', {
  hooks_file: '~/vimfiles/rc/dein/milfeulle.vim',
})

dein#add('hokorobi/vim-smarthome', {
  frozen: 1,
  hooks_file: '~/vimfiles/rc/dein/smarthome.vim',
})

dein#add('osyo-manga/vim-operator-stay-cursor', {
  depends: 'vim-operator-user',
  on_func: 'operator#stay_cursor#wrapper',
  hooks_file: '~/vimfiles/rc/dein/operator-stay-cursor.vim',
})

# 遅延読み込みだと前回起動時のマークが復元されない様子
dein#add('hokorobi/vim-bookmarks', {
  #rev: 'hokorobi',
  frozen: 1,
  hooks_file: '~/vimfiles/rc/dein/bookmarks.vim',
})

dein#add('Allianaab2m/jumpout.vim', {
  on_func: 'jumpout#',
  hooks_file: '~/vimfiles/rc/dein/jumpout.vim',
})

# }}}1  Buffer {{{1

dein#add('hokorobi/vim-sayonara', {
  on_func: 'sayonara#',
  frozen: 1,
  hooks_file: '~/vimfiles/rc/dein/sayonara.vim',
})

dein#add('tyru/closesubwin.vim', {
  on_func: 'closesubwin#',
  hooks_file: '~/vimfiles/rc/dein/closesubwin.vim',
})

dein#add('tyru/capture.vim', {
  on_cmd: 'Capture',
  hooks_file: '~/vimfiles/rc/dein/capture.vim',
})

# }}}1  File {{{1

dein#add('kana/vim-gf-user', {
  on_map: {n: 'gf'},
  hooks_file: '~/vimfiles/rc/dein/gf-user.vim',
})

# diff でも gf を可能にする
dein#add('kana/vim-gf-diff', {
  on_ft: 'diff',
  depends: 'vim-gf-user',
})

# FIXME: 遅延読込設定をしている場合、起動後の初回実行時にファイルの内容が二重に表示される
#        ファイル末尾にファイルの先頭からの内容が表示される。本当に先頭からではなく2行目からの様子
#        sample: :e https://raw.githubusercontent.com/Mathiasb17/mathias/f3ad028eafcc56ddd4d72019cb6a1818e456d099/.config/nvim/init.vim
dein#add('lambdalisue/vim-protocol')

dein#add('mattn/vim-findroot', {
  on_event: 'BufRead',
  hooks_file: '~/vimfiles/rc/dein/findroot.vim',
})

dein#add('chrisbra/Recover.vim')

# }}}1  Terminal {{{1
# terminal 上で、未入力時に ESC, : が効くようにする
dein#add('tyru/empty-prompt.vim', {
  on_event: 'TerminalOpen',
  hooks_file: '~/vimfiles/rc/dein/empty-prompt.vim',
})

dein#add('voldikss/vim-floaterm', {
  on_cmd: 'FloatermNew',
  on_func: 'floaterm#',
  hooks_file: '~/vimfiles/rc/dein/floaterm.vim',
})

# }}}1  CtrlP {{{1
dein#add('ctrlpvim/ctrlp.vim', {
  hooks_file: '~/vimfiles/rc/dein/ctrlp.vim',
})

dein#add('hokorobi/ctrlp-sessions', {
  on_cmd: ['CtrlPSession', 'MkS'],
  hooks_file: '~/vimfiles/rc/dein/ctrlp-sessions.vim',
})

dein#add('mattn/ctrlp-launcher', {
  on_cmd: 'CtrlPLauncher',
  hooks_file: '~/vimfiles/rc/dein/ctrlp-launcher.vim',
})

dein#add('printesoi/ctrlp-filetype.vim', {
  on_cmd: 'CtrlPFiletype',
  hooks_file: '~/vimfiles/rc/dein/ctrlp-filetype.vim',
})

dein#add('christoomey/ctrlp-generic', {
  on_func: 'CtrlPGeneric',
  hooks_file: '~/vimfiles/rc/dein/ctrlp-generic.vim',
})

dein#add('hokorobi/ctrlp-filter', {
  on_func: 'ctrlp#filter#do',
  frozen: 1,
  hooks_file: '~/vimfiles/rc/dein/ctrlp-filter.vim',
})

dein#add('suy/vim-ctrlp-commandline', {
  hooks_file: '~/vimfiles/rc/dein/ctrlp-commandline.vim',
})

dein#add('mattn/ctrlp-matchfuzzy', {
  hooks_file: '~/vimfiles/rc/dein/ctrlp-matchfuzzy.vim',
})

dein#add('ompugao/ctrlp-kensaku', {
  depends: ['denops.vim', 'kensaku.vim'],
  on_cmd: 'CtrlPKensaku',
  hooks_file: '~/vimfiles/rc/dein/ctrlp-kensaku.vim',
})

dein#add('lambdalisue/kensaku.vim', {
  lazy: 1,
})

# }}}1  Git {{{1
dein#add('lambdalisue/gina.vim', {
  on_cmd: 'Gina',
  hooks_file: '~/vimfiles/rc/dein/gina.vim',
})

dein#add('lambdalisue/gin.vim', {
  on_cmd: ['Gin', 'GinBranch', 'GinBuffer', 'GinChaperon', 'GinDiff', 'GinEdit', 'GinLog', 'GinPatch', 'GinStatus'],
  dependns: 'denops.vim',
  hooks_file: '~/vimfiles/rc/dein/gin.vim',
})

dein#add('cohama/agit.vim', {
  on_cmd: 'Agit',
  hooks_file: '~/vimfiles/rc/dein/agit.vim',
})

dein#add('hotwatermorning/auto-git-diff', {
  on_ft: 'gitrebase',
})

# GitHub {{{2
dein#add('lambdalisue/vim-gista', {
  on_cmd: 'Gista',
  on_map: '<Plug>',
  dependns: 'open-browser.vim',
  hooks_file: '~/vimfiles/rc/dein/gista.vim',
})

# }}}2
# }}}1 Utility {{{1
dein#add('tyru/open-browser.vim', {
  on_map: '<Plug>(openbrowser-',
  on_func: 'openbrowser#open',
  hooks_file: '~/vimfiles/rc/dein/open-browser.vim',
})

dein#add('tyru/open-browser-unicode.vim', {
  on_cmd: 'OpenBrowserUnicode',
  depends: 'open-browser.vim',
  hooks_file: '~/vimfiles/rc/dein/open-browser-unicode.vim',
})

dein#add('thinca/vim-prettyprint', {
  on_cmd: 'PP',
  hooks_file: '~/vimfiles/rc/dein/prettyprint.vim',
})

dein#add('kana/vim-operator-user')

dein#add('skanehira/code2img.vim', {
  on_cmd: 'Code2img',
})

dein#add('fedorenchik/VimCalc3', {
  on_cmd: 'Calc',
  hooks_file: '~/vimfiles/rc/dein/calc3.vim',
})

dein#add('kana/vim-submode', {
  on_source: ['vim-lsp', 'yankround.vim', 'vim-easymotion'],
  hooks_file: '~/vimfiles/rc/dein/submode.vim',
})

dein#add('vim-jp/vimdoc-ja')

dein#add('tweekmonster/helpful.vim', {
  on_cmd: 'HelpfulVersion',
  hooks_file: '~/vimfiles/rc/dein/helpful.vim',
})

dein#add('rbtnn/vim-layout', {
  depends: 'ctrlp-generic',
  on_func: ['layout#', 'LayoutWrap', 'LayoutCallback'],
  on_cmd: ['LayoutLoad', 'LayoutSave'],
  hooks_file: '~/vimfiles/rc/dein/layout.vim',
})

dein#add('vim-denops/denops.vim', {
  lazy: 1,
  hooks_file: '~/vimfiles/rc/dein/denops.vim',
})
# }}}1
