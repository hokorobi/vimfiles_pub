" hook_add {{{
let g:hey_openai_api_key = g:open_api_key
call extend(g:vimrc_altercmd_dic, #{
      \   hey: 'Hey',
      \   hc: 'Hey 以下の文章をコミットメッセージとして適切な英語に翻訳。文章:',
      \   ht: 'Hey 以下の文章を英語に翻訳して。文章:',
      \ })
" }}}
