# Security and compliance in Azure Devops

## How to set variables in Release Pipeline

`variables`

- This is define within yaml pipeline/build pipeline
- It helps to define and reuse a valie within the pipeline
- The value of the variables can chnage from run to run or job to job
- you can define thesame variable in different places. The most locally scoped variable will take effect

`Pipeline Variables`

- Click variables -> pipeline variables to set the value/key pair
- Have the values in place within the pipeline ref with `$( )`
- For any password related values, click on the lock sign, so that you can change it to secret value
- if you want the value to be set at release time, you will check `release`
- This is use in classic release pipeline and its only accessible to that pipeline

`Variable Groups`

- You can use it to store values and secrets
- You can access the value from `yaml pipelines`
- Variable groups can be used across multiple pipelines within a project.
- You can use Azure CLI to work with variable groups

## To create variable groups

azure project -> library -> variable group (click) variable group name:<variable Group - name> -> add (click) name: <variable-name>, value <varaible-value> -> save

- Go to the build pipeline and ref it in your yaml pipeline as:

```yaml
trigger:
- main

pool:
  vmImage: ubuntu-latest

variables:
- group: SharedVariables # SharedVariables is the variable Group name

steps:
  - script: |
      echo $(databaseServerName)
    
```

How to ref it in classic pipeline:

- Add all the variables you want to use in your release pipeline in the variable group in your azure library

- variables (click) -> Variable Groups -> link variable group -> choose the variable group you created -> link -> save
- This variables are now available to all your pipelines at thesame time