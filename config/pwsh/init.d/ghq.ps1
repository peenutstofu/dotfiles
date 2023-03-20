if (-not (Test-Command ghq)) {
    return
}

if (-not (Test-Command fzf)) {
    return
}

function g {
    cd $(ghq list -p | fzf)
}