# Blue-Green Deployment with Azure Load Balancer

- Create two azure VMs and do the below for each of the machines
  - windows server 2019 Datacenter
  - port 80 and 3389
  - install IIS
  - open notepad to create `Default.html` file and save in c://inetpub/wwwroot
  - Remove the public ips for the machines
- Create Azure load balancer
  - Type:public, sku:standard, Tier: Region
  - Add frontend ip configuration
  - Add backend pool - Add each vm with private ip address.
  - production-pool and staging-pool
  - Define the `ProbeA` health probe
  - load balancing rules. RuleA `map` to Production pool.
    - port 80, backend port 80, health probe `ProbeA`
  - RuleB `map` to staging-pool
- Add A record to godaddy with value the ip address of the ALB

## How to perform Blue-Green Deployment

- Deploy app with release pipeline to stagging pools using deployment grops in azure devops
- Go to load balancing rule and change the backend pool to staging-pool.
- You can use `release pipeline` with `Azure Powershell script task` to switch the backend pool
  - Use `latest` Azure powershell version
  - Use inline script
  - create a release pipeline

```powershell
$ResourceGroupName="load-grp"
$LoadBalancerName="app-balancer"
$BackEndPoolName="staging-pool"

$LoadBalancer = Get-AzLoadBalancer -Name $LoadBalancerName -ResourceGroupName $ResourceGroupName
$Probe=Get-AzLoadBalancerProbeConfig -Name "probeA" -LoadBalancer $LoadBalancer
$BackendPool = Get-AzLoadBalancerBackendAddressPool -ResourceGroupName $ResourceGroupName -LoadBalancerName $LoadBalancerName -Name $BackEndPoolName

$LoadBalancer | Set-AzLoadBalancerRuleConfig -Name "RuleA" -FrontendIPConfiguration $LoadBalancer.FrontendIpConfigurations[0] -Protocol "Tcp" -FrontendPort 80 -BackendPort 80 -BackendAddressPool $BackendPool -Probe $Probe
$LoadBalancer | Set-AzLoadBalancer
```