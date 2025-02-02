* `Compare-Object (Get-Content fileA) (Get-Content fileB)` | Out-File -filepath diff.txt -width 4000 -Encoding UTF8: Output diff.txt to diff fileA fileB. =>: 右ファイルからなくなった行, <=: 左ファイルからなくなった行
* `man commandlet` : ヘルプ表示。 -online: Web ブラウザで表示, alias: Get-Help, help
* `Get-Content file`: ファイルの表示。 alias: cat, type
* `New-Item -type file $profile`: PowerShell 設定ファイル作成
* `Get-ChildItem -Filter *.vim -Recurse -Hidden | %{hoge $_.FullName}`: 拡張子 vim に対して hoge を実行。
* `Get-ChilItem "C:\Users\" -recurse -include *passowords*.txt`: C:\Users 配下の *passwords*.txt を表示。
* `Get-HotFix`: インストールしたホットフィックスを表示
* `cd HKLM:\`: レジストリへ
* `ls HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\run`: 自動起動するプログラムの一覧
* `Get-Command`: which として使える。where.exe も同じ。
