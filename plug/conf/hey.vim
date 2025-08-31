" hook_add {{{
call extend(g:vimrc_altercmd_dic, #{
      \   hey: 'Hey',
      \   hc: 'Hey 以下の文章をコミットメッセージとして適切な英語に翻訳。文章:',
      \   ht: 'Hey 以下の文章を英語に翻訳して。文章:',
      \ })
" }}}
" hook_source {{{
let g:hey_google_api_key = g:gemini_api_key
let g:hey_model_name = 'gemini-2.0-flash'
let g:hey_service_type = 'google'
" }}}
