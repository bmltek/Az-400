# Variables
$TrafficManagerProfileName = "developapp"
$ResourceGroupName = "template-rg"

# Staging environment
$StagingTargetResourceId = "/subscriptions/a14b6cfe-8553-4b23-b354-d5602f0f84aa/resourceGroups/template-rg/providers/Microsoft.Web/sites/staggingdeployment2"
$StagingTargetEndPoint = "staggingdeployment2.azurewebsites.net"

# Production environment
$ProductionTargetResourceId = "/subscriptions/a14b6cfe-8553-4b23-b354-d5602f0f84aa/resourceGroups/template-rg/providers/Microsoft.Web/sites/proddeployment1"
$ProductionTargetEndPoint = "proddeployment1.azurewebsites.net"

# Create Staging Endpoint
$StagingTrafficManagerEndpoint = New-AzTrafficManagerEndpoint -Name "staging" `
    -ProfileName $TrafficManagerProfileName -Type AzureEndpoints `
    -TargetResourceId $StagingTargetResourceId -EndpointStatus Enabled `
    -Weight 100 -ResourceGroupName $ResourceGroupName

# Add Custom Header to Staging Endpoint
Add-AzTrafficManagerCustomHeaderToEndpoint -TrafficManagerEndpoint $StagingTrafficManagerEndpoint -Name "host" -Value $StagingTargetEndPoint
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $StagingTrafficManagerEndpoint

# Create Production Endpoint
$ProductionTrafficManagerEndpoint = New-AzTrafficManagerEndpoint -Name "production" `
    -ProfileName $TrafficManagerProfileName -Type AzureEndpoints `
    -TargetResourceId $ProductionTargetResourceId -EndpointStatus Enabled `
    -Weight 100 -ResourceGroupName $ResourceGroupName

# Add Custom Header to Production Endpoint
Add-AzTrafficManagerCustomHeaderToEndpoint -TrafficManagerEndpoint $ProductionTrafficManagerEndpoint -Name "host" -Value $ProductionTargetEndPoint
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $ProductionTrafficManagerEndpoint
