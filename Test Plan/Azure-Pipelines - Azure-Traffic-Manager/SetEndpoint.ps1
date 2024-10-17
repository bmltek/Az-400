$TrafficManagerEndpoint = Get-AzTrafficManagerEndpoint -Name "production" -Type AzureEndpoints -ProfileName "developapp" -ResourceGroupName "template-rg"
$TrafficManagerEndpoint.Weight = 1
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint


$TrafficManagerEndpoint = Get-AzTrafficManagerEndpoint -Name "staging" -Type AzureEndpoints -ProfileName "developapp" -ResourceGroupName "template-rg"
$TrafficManagerEndpoint.Weight = 1000
Set-AzTrafficManagerEndpoint -TrafficManagerEndpoint $TrafficManagerEndpoint

