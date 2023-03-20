if (-not (Test-Command scoop)) {
    return
}

$SCOOP_COMPLETION_PATH="$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)\modules\scoop-completion"
if (Test-Path $SCOOP_COMPLETION_PATH) {
  Import-Module $SCOOP_COMPLETION_PATH
}

if (Test-Path scoop-search) {
  Invoke-Expression (&scoop-search --hook)
}