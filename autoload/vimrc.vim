vim9script
scriptencoding utf-8

# tabpanel setting {{{
# https://zenn.dev/utubo/articles/20250526-show-hiddens-in-tabpanel
def BufLabel(b: dict<any>): string
  const current = b.bufnr ==# bufnr('%') ? '>' : ' '
  const mod = !b.changed ? '' : '+'
  const nr = !b.hidden ? '' : $'{b.bufnr}:'
  const name = b.name->fnamemodify(':t') ?? '[No Name]'
  const width = &tabpanelopt
    ->matchstr('\(columns:\)\@<=\d\+') ?? '20'
  return $' {current}{mod}{nr}{name}'
    ->substitute($'\%{width}v.*', '>', '')
enddef
export def TabPanel(): string
  var label = [$'{g:actual_curtabpage}']
  for b in tabpagebuflist(g:actual_curtabpage)
    label->add(b->getbufinfo()[0]->BufLabel())
  endfor

  # Show Hiddens
  if g:actual_curtabpage ==# tabpagenr('$')
    const hiddens = getbufinfo({ buflisted: 1 })
      ->filter((_, v) => v.hidden)
    if !!hiddens
      label->add('%#TabPanel#Hidden')
      for h in hiddens
        label->add($'%#TabPanel#{h->BufLabel()}')
      endfor
    endif
  endif

  return label->join("\n")
enddef
# }}}

export def UseEasyRegname()
  if v:event.regname !=# ''
    return
  endif

  if !exists('g:UseEasyRegnameNonameBak')
    g:UseEasyRegnameNonameBak = getreg()
  endif
  setreg(v:event.operator, g:UseEasyRegnameNonameBak)
  g:UseEasyRegnameNonameBak = getreg()
enddef

# def で定義している関数を変更、追加した場合は一時的にコメントを外してエラーがないか確認する。
# defcompile
