# OWASP Release Pipeline

## azure web App Deploy

Take your artifacts and deploy in your existing azure web app

## Azure CLI - Create storage Account/file share

This will help to store OWASP Zap tool report

```azure cli
az storage account create -g template-rg -n owaspstore22241986 -l northeurope --sku Standard_LRS
az storage share create -n security --account-name owaspstore22241986

```

Copy the access key for storage account, in other for us to access the file share

## Azure CLI - create Azure container instance

```azure cli
# Retrieve the storage account Access key
az storage account keys list -g template-rg --account-name owaspstore22241986 --query "[0].value" --output tsv > temp.txt
$content = Get-Content temp.txt -First 1
$key = '"{0}"' -f $content
Write-Output $key

# Set the URL of webapp that we want to test
# Change url based on your Azure webapp url
echo "https://boniton86.azurewebsites.net" > url.txt
$url = Get-Content url.txt -First 1
$completeurl = '"{0}"' -f $url

# Define the ZAP command
# Call the zap baseline application that is going to run within the container
# OWASP-ZAP-Report.xml: This is the name of the report that need to be generated
# testreport.html: this is the html format test report
# File share name: security
# The file share is mounted to /zap/wrk directory on the container instance

$ZAP_COMMAND = "zap-baseline.py -t $completeurl -x OWASP-ZAP-Report.xml -r testreport.html"

# Run the az container create command with the updated image
az container create `
    --resource-group template-rg `
    --name owasp `
    --image ghcr.io/zaproxy/zaproxy:stable `
    --ip-address public `
    --ports 8080 `
    --azure-file-volume-account-name owaspstore22241986 `
    --azure-file-volume-account-key $content `
    --azure-file-volume-share-name security `
    --azure-file-volume-mount-path "/zap/wrk" `
    --command-line $ZAP_COMMAND `
    --restart-policy Never
```

## Azure CLI - Download Report

```azure cli
# Wait for 30 seconds
Start-Sleep -Seconds 30

# Retrieve the storage account key and store it in temp.txt
az storage account keys list -g template-rg --account-name owaspstore22241986 --query "[0].value" --output tsv > temp.txt

# Read the content of temp.txt and format it as needed
$content = Get-Content temp.txt -First 1
$key = $content.Trim()  # Remove any extra whitespace or new lines

# Define the destination path for the downloaded file
$destinationPath = Join-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY "OWASP-ZAP-Report.xml"

# Download the file from the Azure File Share
az storage file download --account-name owaspstore22241986 --account-key $key -s security -p OWASP-ZAP-Report.xml --dest $destinationPath

```

## PowerShell Script - Convert Report

Make sure you give the location of the files accordingly.
- Browze for the files accordingly
```powershell
$XslPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\_sqldatabase (24)\xslt-artifact\OWASPToNUnit3.xslt"
$XmlInputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\OWASP-ZAP-Report.xml"
$XmlOutputPath = "$($Env:SYSTEM_DEFAULTWORKINGDIRECTORY)\Converted-OWASP-ZAP-Report.xml"
$XslTransform = New-Object System.Xml.Xsl.XslCompiledTransform
$XslTransform.Load($XslPath)
$XslTransform.Transform($XmlInputPath, $XmlOutputPath)
```

## Publish Test results

Test result format : NUnit
Test results files : Converted-OWASP-ZAP-Report.xml