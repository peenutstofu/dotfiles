function Remove-InvalidFileNameChars {
	param(
		[Parameter(Mandatory=$true,
		Position=0,
		ValueFromPipeline=$true,
		ValueFromPipelineByPropertyName=$true)]
		[String]$Name
	)

	$invalidChars = [IO.Path]::GetInvalidFileNameChars() -join ''
	$re = "[{0}]" -f [RegEx]::Escape($invalidChars)
	return ($Name -replace $re)
  }
