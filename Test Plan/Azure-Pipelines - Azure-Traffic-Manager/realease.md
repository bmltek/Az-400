# Canary Deployment strategy - weighted routing method

- Create release Pipeline
- export artifact to the release pipeline
- `Stage Name` - Create Traffic manager endpoint
- Azure app service deploy - `Task`
  - display name : Deploy staging application
- Azure powershell - `Task`
  - display name - Create Traffic manager endpoint
  - inline scrripts

```powershell
$TrafficManagerProfileName = "developapp"
$ResourceGroupName = "template-rg"

# Staging environment
$StagingTargetResourceId = "/subscriptions/a14b6cfe-8553-4b23-b354-d5602f0f84aa/resourceGroups/template-rg/providers/Microsoft.Web/sites/staggingdeployment2"
$StagingTargetEndPoint = "staggingdeployment2.azurewebsites.net"

# Create Staging Endpoint
$StagingTrafficManagerEndpoint = New-AzTrafficManagerEndpoint -Name "staging" `
    -ProfileName $TrafficManagerProfileName -Type AzureEndpoints `
    -TargetResourceId $StagingTargetResourceId -EndpointStatus Enabled `
    -Weight 100 -ResourceGroupName $ResourceGroupName

# Add Custom Header to Staging Endpoint
Add-AzTrafficManagerCustomHeaderToEndpoint -TrafficManagerEndpoint $StagingTrafficManagerEndpoint -Name "host" -Value $StagingTargetEndPoint
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $StagingTrafficManagerEndpoint
```

- Azure Powershell version - use `latest`

- create another stage for production
- `Stage Name` - Create Traffic manager production endpoint
- Azure app service deploy - `Task`
  - display name : Deploy production application
- Azure powershell - `Task`
  - display name - Create Traffic manager production endpoint
  - inline scrripts

```powershell
# Variables
$TrafficManagerProfileName = "developapp"
$ResourceGroupName = "template-rg"

# Production environment
$ProductionTargetResourceId = "/subscriptions/a14b6cfe-8553-4b23-b354-d5602f0f84aa/resourceGroups/template-rg/providers/Microsoft.Web/sites/proddeployment1"
$ProductionTargetEndPoint = "proddeployment1.azurewebsites.net"

# Create Production Endpoint
$ProductionTrafficManagerEndpoint = New-AzTrafficManagerEndpoint -Name "production" `
    -ProfileName $TrafficManagerProfileName -Type AzureEndpoints `
    -TargetResourceId $ProductionTargetResourceId -EndpointStatus Enabled `
    -Weight 100 -ResourceGroupName $ResourceGroupName

# Add Custom Header to Production Endpoint
Add-AzTrafficManagerCustomHeaderToEndpoint -TrafficManagerEndpoint $ProductionTrafficManagerEndpoint -Name "host" -Value $ProductionTargetEndPoint
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $ProductionTrafficManagerEndpoint
```

## Another stage is created on the pipeline to change the weightage of the endpoints

- create `Azure powershell` task to change the weightage of the endpoints

```powershell
$TrafficManagerEndpoint = Get-AzTrafficManagerEndpoint -Name "production" -Type AzureEndpoints -ProfileName "developapp" -ResourceGroupName "template-rg"
$TrafficManagerEndpoint.Weight = 1
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint


$TrafficManagerEndpoint = Get-AzTrafficManagerEndpoint -Name "staging" -Type AzureEndpoints -ProfileName "developapp" -ResourceGroupName "template-rg"
$TrafficManagerEndpoint.Weight = 1000
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint
```