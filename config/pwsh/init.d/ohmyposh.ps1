if (-not (Test-Command oh-my-posh)) {
    return
}

$THEME_DIR="~/scoop/apps/oh-my-posh/current/themes/"
$THEME="amro.omp.json"

oh-my-posh init pwsh --config $THEME_DIR/$THEME | Invoke-Expression