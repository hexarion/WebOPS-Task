$ListFile = Read-host -prompt "Please enter the directory of the file you want to copy" 
get-childitem $ListFile
$Filename = Read-host -prompt "Please enter the name of the file you want to copy"
$FilePath = Join-Path $ListFile $FileName


if (Test-Path $FilePath)
{
	$destination = Read-host -prompt "Please enter the destination directory"
	Copy-item $FilePath $destination
	Write-Host "The file was successfuly copied to $destination"
}
else
{
	Write-host "No such file was found"
}