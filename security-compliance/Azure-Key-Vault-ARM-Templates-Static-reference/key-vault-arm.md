# ARM integration with Key-Vault

## Static way to embed a reference onto azure key vault when it comes to secret

Go to key-vault -> Access policies -> enable access to: Azure Resource Manager for template deployment -> save

- Give the managed service principal created by azure devops in azure account microsoft extra access to secret: list, get
- upload both parameter file and the sqldatabase file to azure Cloud-shell and run accordingly.
- Run:

```azure cli
az deployment group create -g template-rg --template-file sqldatabase.json --parameters sqldatabase-parameters.json

```