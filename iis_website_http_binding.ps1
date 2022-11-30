Import-Module WebAdministration
$iisAppPoolName = “iiswebtest”
$iisAppPoolDotNetVersion = "v4.0"
$iisAppName = "iiswebtest"
$directoryPath = "C:\inetpub\wwwroot"

#navigate to the app pools root
cd IIS:\AppPools\

#check if the app pool already exists
if (!(Test-Path $iisAppPoolName -pathType container))
{
	#create the app pool
	$appPool = New-Item $iisAppPoolName
	$appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
	$appPool | Set-ItemProperty -Name "enable32BitAppOnWin64" -Value "FALSE"           
	$appPool | Set-ItemProperty -Name "processModel.loadUserProfile" -Value "TRUE"
	$group = [ADSI]"WinNT://ComputerName/IIS_IUSRS,group"
	$ntAccount = New-Object System.Security.Principal.NTAccount("IIS APPPOOL\$iisAppPoolName")
	$strSID = $ntAccount.Translate([System.Security.Principal.SecurityIdentifier])
	$user = [ADSI]"WinNT://$strSID"
	$group.Add($user.Path)
}

#navigate to the sites root
cd IIS:\Sites\

#check if the site already exists
if (Test-Path $iisAppName -pathType container)
{
	Write-Host "The site already exists"
}
else
{
	#create the site
	$port = 8080
	$iisApp = New-Item $iisAppName -bindings @{protocol=”http”;bindingInformation=":8080:"} -physicalPath $directoryPath
	$iisApp | Set-ItemProperty -Name “applicationPool” -Value $iisAppPoolName

	Write-Output $iisApp
}