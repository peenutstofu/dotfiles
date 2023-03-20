Remove-Item alias:cd
function cd($dir){
  if ( $dir ) {
    set-location -path $dir
    return
    }
  set-location -path ~
}