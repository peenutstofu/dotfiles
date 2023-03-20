$KindleDir = "$HOME\Documents\My Kindle Content"
$CalibreDir = "$HOME\scoop\apps\calibre\current\Calibre Library"

function Add-Calibre() {
  Get-ChildItem $KindleDir -Recurse -Filter "*.azw" | foreach {
    Write-Host $_.FullName
    calibredb add $_.FullName
  }
}

function Get-Ebook-MetaInfo($ebookPath) {
  $metainfo = ebook-meta $ebookPath
  $title = echo $metainfo | Select-String -Pattern "^Title *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }
  $authors = echo $metainfo | Select-String -Pattern "^Author[(]s[)] *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }
  $publisher = echo $metainfo | Select-String -Pattern "^Publisher *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }
  $languages = echo $metainfo | Select-String -Pattern "^Languages *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }
  $published = echo $metainfo | Select-String -Pattern "^Published *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }
  $Identifiers = echo $metainfo | Select-String -Pattern "^Identifiers *: *(.*)" | %{ $_.Matches.Groups[1].Value.Replace("`n", "") }

  $result = [PsCustomObject]@{
    Title = $title
    Authors = $authors
    Publisher = $publisher
    Languages = $languages
    Published = $published
    Identifiers = $Identifiers
  }

  return $result
}

function Kindle2Pdf($outputDir) {
  if (-not (Test-Path $outputDir)) {
    mkdir $outputDir
  }
  Get-ChildItem $CalibreDir -Recurse -Filter "*.azw3" | foreach {
    $title = Get-Ebook-MetaInfo($_) | %{ $_.Title }
    $escapedTitle = Remove-InvalidFileNameChars $title
    $filename =  [System.IO.Path]::GetDirectoryName($_) + "\" + $escapedTitle + ".pdf"
    if (-not (Test-Path $filename)) {
      Write-Host 'convert' $filename
      ebook-convert $_.FullName $filename > $null
      return
    }
    Write-Host 'skiped convert' $filename
  }
  Get-ChildItem $CalibreDir -Recurse -Filter "*.pdf" | foreach {
    Copy-Item $_.FullName $outputDir
  }
}

function Kindle2Epub($outputDir) {
  if (-not (Test-Path $outputDir)) {
    mkdir $outputDir
  }
  Get-ChildItem $CalibreDir -Recurse -Filter "*.azw3" | foreach {
    $title = Get-Ebook-MetaInfo($_) | %{ $_.Title }
    $escapedTitle = Remove-InvalidFileNameChars $title
    $filename =  [System.IO.Path]::GetDirectoryName($_) + "\" + $escapedTitle + ".epub"
    if (-not (Test-Path $filename)) {
      Write-Host 'convert' $filename
      ebook-convert $_.FullName $filename > $null
      return
    }
    Write-Host 'skiped convert' $filename
  }
  Get-ChildItem $CalibreDir -Recurse -Filter "*.epub" | foreach {
    Copy-Item $_.FullName $outputDir
  }
}