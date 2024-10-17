# Store this script in a storage account
# dowmload .net hosting bundle exe and store in a container called 'installers' in storage account
# Install IIS on the vm
Install-WindowsFeature -name Web-Server -IncludeManagementTools
# write output of installed IIS
Write-Output "Installed IIS"

New-Item -Path "D:\" -Name "tmp" -ItemType "directory"
# create a temporarry directory on the vm
$Path = "D:\tmp\"
# download the installer and store it in storage account
$Url = "https://templatestore465656.blob.core.windows.net/installers/dotnet-hosting-6.0.8-win.exe"

$Location = $Path + [System.IO.Path]::GetFileName($Url)
# with the help of Invoke-WebRequest, go to the url and download the exe file into the tmp directory
Invoke-WebRequest -Uri $Url -OutFile $Location
# with the help of Start-Process, you will start the installation of donet hosting bundle
Start-Process -FilePath $Location -Wait -ArgumentList /passive
# Stopping Internet Information Services and then starting it again
net stop was /y
net start w3svc
# write output of 'Installed Hosting Bundle'
Write-Output "Installed Hosting Bundle"


