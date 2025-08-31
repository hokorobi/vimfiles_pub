" hook_add {{{
let g:ddc_source_filetype_candidates_files = {}
let g:ddc_source_filetype_candidates_files['autohotkey'] = expand('~/vimfiles/plug/ddc/autohotkey.txt')
let g:ddc_source_filetype_candidates_files['plantuml'] = expand('~/vimfiles/plug/ddc/plantuml.txt')
" }}}
" hook_source {{{
let s:ddc_sourceOptions = {}
let s:ddc_sourceParams = {}
let s:ddc_sourceOptions['_'] = #{
    \   matchers: ['matcher_fuzzy'],
    \   converters: ['converter_fuzzy'],
    \   sorters: ['sorter_fuzzy'],
    \   ignoreCase: v:true,
    \   timeout: 1000,
    \ }
let s:ddc_sourceOptions['buffer'] = #{
    \   mark: 'B',
    \   maxKeywordLength: 30,
    \ }
let s:ddc_sourceOptions['file'] = #{
    \   mark: 'F',
    \   isVolatile: v:true,
    \ }
let s:ddc_sourceParams['file'] = #{
    \   mode: 'win32',
    \ }
let s:ddc_sourceOptions['filetype-candidates'] = #{
    \   mark: 'D',
    \ }
let s:ddc_sourceOptions['vim'] = #{
    \   mark: 'V',
    \   isVolatile: v:true,
    \ }
" https://github.com/kuuote/dotvim/blob/7fbd83a2aedb1e30405f9bd1d8126b04dc5fe72e/conf/vim-lsp.toml#L50
" メソッド呼び出しを補完
let s:ddc_sourceOptions['vim-lsp'] = #{
    \   mark: 'L',
    \   forceCompletionPattern: '\..?',
    \   minAutoCompleteLength: 2,
    \ }
let s:ddc_sourceOptions['vsnip'] = #{
    \   mark: 'S',
    \ }

let s:ddc_options = #{
    \   sourceOptions: s:ddc_sourceOptions,
    \   sourceParams: s:ddc_sourceParams,
    \ }
" Shougo/pum.vim
call extend(s:ddc_options, #{
    \   ui: 'pum',
    \   backspaceCompletion: v:true,
    \ })
" tani/ddc-fuzzy
call extend(s:ddc_options, #{
    \   filterParams: #{
    \     converter_fuzzy: #{
    \       hlGroup: 'SpellBad'
    \     }
    \ }})
call ddc#custom#patch_global(s:ddc_options)

call ddc#custom#patch_filetype(
    \ ['autohotkey', 'plantuml'],
    \ #{sources: ['vsnip', 'buffer', 'filetype-candidates', 'file']})
call ddc#custom#patch_filetype(
    \ ['rst'],
    \ #{sources: ['vsnip', 'buffer', 'file']})
call ddc#custom#patch_filetype(
    \ ['go', 'python', 'toml', 'typescript'],
    \ #{sources: ['vsnip', 'vim-lsp', 'file']})
call ddc#custom#patch_filetype(
    \ ['cfg', 'gitcommit', 'howm', 'javascript', 'markdown', 'snippet', 'vb', 'xsl'],
    \ #{sources: ['buffer', 'file']})
call ddc#custom#patch_filetype(
    \ ['vim'],
    \ #{sources: ['vsnip', 'vim', 'buffer', 'file']})

" <Tab> は
" 1. ddc.vim を使用しない filetype では <Tab>
" 2. popupが表示されている場合、次の候補へ
" 3. vsnipのジャンプができる場合、次のジャンプ位置へ
" 4. それ以外は <Tab>
imap <silent><expr> <Tab>
      \ !has_key(ddc#custom#get_filetype(), &filetype) ? '<Tab>' :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
      \ '<Tab>'
smap <silent><expr> <Tab>
      \ vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' :
      \ '<Tab>'
" <C-l> は
" 1. popup が表示されていて、vsnip の展開ができる場合は展開する
" 2. popup が表示されていて、vsnip の展開ができない場合は選択している候補を挿入してpopupを閉じる
" 3. vsnipのジャンプができる場合、次のジャンプ位置へ
" 4. それ以外は何もしない
imap <silent><expr> <C-l>
      \ pum#visible() ? vsnip#expandable() ? '<Plug>(vsnip-expand)': '<Cmd>call pum#map#confirm()<CR>' :
      \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
      \ ''
imap <silent><expr> <C-j>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ '<C-j>'
imap <silent><expr> <S-Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' :
      \ vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' :
      \ '<C-h>'
smap <silent><expr> <S-Tab>
      \ vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' :
      \ '<S-Tab>'
imap <silent><expr> <C-k>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' :
      \ '<Cmd>normal! D<CR>'
" 普段 <C-j> を使っているが押し間違えるので <C-n> も設定しておく。
imap <silent><expr> <C-n>
     \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
     \ '<Cmd>normal! gj<CR>'
smap <silent><expr> <C-n>
     \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
     \ '<C-n>'
imap <silent><expr> <C-p>
     \ pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' :
     \ '<Cmd>normal! gk<CR>'
" 直前の insert mode の IME の状態を保持する設定が無効化されるのでコメントアウト
" imap <silent><expr> <Esc>
"     \ pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' :
"     \ '<Esc>'

let g:vsnip_snippet_dir = expand('~/vimfiles/plug/vsnip')

call ddc#enable()
" }}}
