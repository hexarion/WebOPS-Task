$FolderName = "C:\inetpub\wwwroot"
if (Test-Path $FolderName)
{
   
    Write-Host "Folder already exists."
}
else
{
    New-Item $FolderName -ItemType Directory
    Write-Host "Directory created."
}