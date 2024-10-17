# create windows vm
# create automation `account`
# automation(overview)-> state configuration (DSC)-> configuration click on `Add`-> upload this configuration file
# Give name. It must be thesame as the configuration name i.e `NewConfig` -> ok -> refresh
# Click on the uploded file -> compile (click) -> yes
# The compile file will be in the `compiled configuration`
# Click on the Nodes -> add -> click on the `vm`-> click `connect` -> choose configuration
# configuration Mode: ApplyAndAutoCorrect -> Allow Module Override ->Reboot Node if needed -> ok

configuration NewConfig
{
    Node localhost # install IIS role on local machine
    {
        WindowsFeature IIS # its a windows feature
        {
            Ensure               = 'Present' # ensure its always present on the machine
            Name                 = 'Web-Server' # web server role
            IncludeAllSubFeature = $true
        }
    }
}


