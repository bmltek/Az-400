
$ResourceGroupName="load-grp"
$LoadBalancerName="app-balancer"
$BackEndPoolName="staging-pool"

$LoadBalancer = Get-AzLoadBalancer -Name $LoadBalancerName -ResourceGroupName $ResourceGroupName
$Probe=Get-AzLoadBalancerProbeConfig -Name "probeA" -LoadBalancer $LoadBalancer
$BackendPool = Get-AzLoadBalancerBackendAddressPool -ResourceGroupName $ResourceGroupName -LoadBalancerName $LoadBalancerName -Name $BackEndPoolName

$LoadBalancer | Set-AzLoadBalancerRuleConfig -Name "RuleA" -FrontendIPConfiguration $LoadBalancer.FrontendIpConfigurations[0] -Protocol "Tcp" -FrontendPort 80 -BackendPort 80 -BackendAddressPool $BackendPool -Probe $Probe
$LoadBalancer | Set-AzLoadBalancer