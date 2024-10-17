# Integrating Azure Key-vault with Azure Devops

Azure Key vault is a managed service in azure that help us to securely store secrets, keys, cert that will be needed within the pipelines.

- Create Azure key vault
- create secret
- Give secret permissions to user or managed service principal created by azure devops within azure account in microsoft extra Id, the access to the key vault
  - Go to access policies -> add access policies -> secret permission: Get, list -> select principle : <organization-name>-<project-name> -> select the appropriate client-ID - ADD - save

## How to access the secret store in Azure Key Vault

```yaml
trigger:
- main

pool:
  vmImage: ubuntu-latest


steps:

- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'Azure subscription 1 (6912d7a0-bc28-459a-9407-33bbba641c07)'
    KeyVaultName: 'appvault787878'
    SecretsFilter: '*'
    RunAsPreJob: false
  
- script: |
      echo $(dbpassword) > dbpassword.txt
# copy the .txt file to target folder
- task: CopyFiles@2
  inputs:
    Contents: dbpassword.txt
    targetFolder: '$(Build.ArtifactStagingDirectory)'

- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(Build.ArtifactStagingDirectory)'
    ArtifactName: 'secrets'
    publishLocation: 'Container'
```

## How to link secrets from azure key vault as variables

- Go to library -> variable groups `created` -> click `link secrets from an Azure Key vault as variables` -> add -> choose secret from the key-vault
- You can start uing the variable groups within the yaml pipeline/release pipeline/classic pipeline.