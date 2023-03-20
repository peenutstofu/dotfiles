# run this with an argument  to install a nerdfont on windows
# run this with no arguments to install all fonts
# font name, as seen on https://www.nerdfonts.com/font-downloads
param(
    [Parameter(Mandatory=$False, Position=0, ValueFromPipeline=$false)]
    [System.String]
    $fontTarget="*"
)

# build temp directory for git clone 
$path = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())

while(Test-Path $path) {
    $path = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
}

new-item -itemtype directory -path $path > $null

$font = @{
    ligatures = $true
    windows = [System.Boolean](Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue)
    version = "v2.1.0"
    family = "*"
    name = $fontTarget
    release = $fontTarget
}

$source = @{
    origin = "https://github.com/ryanoasis/nerd-fonts"
    static = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts" 
    branch = "master"
}

echo "      targeting nerd-font $($font.version) @ $fontTarget"

# build plan
$plan = @()

if (@("*", ".", "") -contains $font.name) {
    # target all fonts
    $list = (New-Object System.Net.WebClient).DownloadString($source.static + "/" + $source.branch + "/bin/scripts/lib/fonts.json") | ConvertFrom-Json

    foreach ($target in $list.fonts) {
        if ($target.description -like "*missing*") {
            # ignore this one
            continue;
        }

        $plan += , @{
            ligatures = $font.ligatures
            windows = $font.windows
            family = $font.family
            release = $target.unpatchedName
            name = $target.patchedName
        }
    }
} else {

    $plan += , $font

}

Push-Location $path

if ($font.windows) {
    $TempFolder  = "C:\Windows\Temp\Fonts"
    
    New-Item $TempFolder -Type Directory -Force > $null

    $Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)

}

$total = $plan.length
$index = 0

foreach ($target in $plan) {
    $directory = "$path/$($target.release)"
    $bundle = "$directory.zip"
    $dl = "$($source.origin)/releases/download/$($font.version)/$($target.release).zip" 

    try {
        (New-Object System.Net.WebClient).DownloadFile(
            $dl,
            $bundle
        )
    } catch {
        echo "      @ $($target.name)'s release @ $dl was not found"

        continue
    }
   
    Expand-Archive -LiteralPath $bundle -DestinationPath $directory

    $search = "*"
    
    if (@("*", ".", "") -notcontains $font.family) {     
        $search = " $($font.family)*"
    }

    echo "$("$index".PadLeft(2,[char]48))/$("$total".PadLeft(2,[char]48)) $($target.name)"

    Join-Path -Path $directory -ChildPath "$($target.name)$search" -Resolve | ForEach-Object {
        if ($_ -like "*.otf" `
       -or ($font.ligatures -and $_ -like "*Mono*") -or (!$font.ligatures -and $_ -notlike "*Mono*") `
       -or ($font.windows -and $_ -notlike "*Windows*")) {
             return
        }


        $title = Split-Path $_ -leaf
        $label = ($title -split "Nerd")[0] 

            
        if (-not(Test-Path "~\AppData\Local\Microsoft\Windows\Fonts\$title")) {
             
            $FontBin = "$TempFolder\$title"
        
            # Copy font to local temporary folder
            Copy-Item $_ -Destination $TempFolder
        
            # Install font
            $Destination.CopyHere($FontBin,0x10) 
                
            echo "    + $label"

        } else {
                
            # already found
            echo "    - $label"
        }
        
    }

    $index = $index + 1

}
Pop-Location
echo "complete"