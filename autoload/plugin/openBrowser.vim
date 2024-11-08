scriptencoding utf-8

function plugin#openBrowser#gitrepo() abort
  let repo = vimrc#getRepositoryName()
  if repo ==# '' || stridx(repo, '/') == -1
    echo 'リポジトリ名は取得できませんでした。'
    return
  endif

  call openbrowser#open('https://github.com/' .. repo)
endfunction

function plugin#openBrowser#openUrlInBuffer() abort
  if &filetype != 'capture' && confirm("Open URLs in buffer?", "&Yes\n&No\n&Cancel") != 1
    return
  endif

  for line in getline(0, line("$"))
    let head = matchstr(line, 'https:\/\/github.com.\+\.\.\..\+')
    if len(head) >= 1
      call openbrowser#open(head)
    endif
  endfor
endfunction
