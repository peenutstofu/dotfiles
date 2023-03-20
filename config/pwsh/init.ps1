# encoding
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# load function.d\*.ps1
Get-ChildItem "$PSScriptRoot\function.d\*.ps1"
| ForEach-Object { . $_.FullName }


# load init.d\*.ps1
Get-ChildItem "$PSScriptRoot\init.d\*.ps1"
| ForEach-Object { . $_.FullName }
