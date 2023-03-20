$DOTFILES = "$env:USERPROFILE/.dotfiles"

# --------------
# Install winget
# --------------
function Get-LatestMsix($uri) {
    $get = Invoke-RestMethod -Uri $uri -Method Get -ErrorAction stop
    $data = ($get | where-object {(-Not $_.Prerelease) -or (-Not $_.Preinstall)} | Select-Object -first 1).Assets | Where-Object name -Match 'msixbundle'
    Return $data.browser_download_url
}

if (Get-Command winget){
    'Winget was found'
} else{
    $wingetUrl = Get-LatestMsix("https://api.github.com/repos/microsoft/winget-cli/releases/latest")
    Invoke-WebRequest -Uri $wingetUrl -OutFile 'winget.msixbundle'

    Invoke-WebRequest -Uri 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile 'Microsoft.VCLibs.x64.14.00.Desktop.appx' 

    Add-AppxPackage 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
    Add-AppxPackage 'winget.msixbundle'

    Remove-Item ./Microsoft.VCLibs.x64.14.00.Desktop.appx
    Remove-Item ./winget.msixbundle
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

winget source update
$WINGET_PACKAGES = @(
    "Google.Chrome"
    "Mozilla.Firefox"
    "Google.JapaneseIME"
    "Google.Drive"
    "Flow-Launcher.Flow-Launcher"
    "Bandisoft.Bandizip"
    "Discord.Discord"
    "Valve.Steam"
    "Microsoft.WindowsTerminal"
    "HeidiSQL"
    "Microsoft.VisualStudioCode"
)
foreach($PACKAGE in $WINGET_PACKAGES){
    winget install $PACKAGE
}
