# Install scoop command
try {
  Get-Command -Name scoop -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser
  Invoke-Expression (new-object net.webclient).downloadstring("https://get.scoop.sh")
}

$DOTFILES = "$env:USERPROFILE/.dotfiles"

# git is required by `scoop bucket add *`
$UTILS = @(
  "lessmsi"
  "dark"
  "mingit"
)

$PACKAGES = @(
  "aws"
  # "bat"
  # "everything"
  "calibre"
  "coursier"
  "fzf"
  # "go"
  # "gcc"
  "ghq"
  # "jq"
  # "ln"
  # "lsd"
  # "neovim"
  # "$DOTFILES/package/scoop/npiperelay.json"
  "oh-my-posh"
  "pwsh"
  # "python"
  # "ruby"
  # "rustup-msvc"
  "scoop-search"
  "scoop-completion"
  "openjdk"
  # "starship"
  "sudo"
  "volta"
  "zenhan"
)

scoop install $UTILS
scoop bucket add extras
scoop bucket add versions
scoop bucket add java
scoop bucket add emulators https://github.com/hermanjustnu/scoop-emulators.git
scoop update *
foreach ($PACKAGE in $PACKAGES) {
  scoop install $PACKAGE
}
