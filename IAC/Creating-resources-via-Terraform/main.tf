terraform {
  required_providers {
    azurerm={
        source="hashicorp/azurerm"
        version="3.17.0"
    }
  }
}

provider "azurerm" {
  # Configuration options for provider
  # Subscription id, tenant id, client id
  # To manage identity use Microsoft extra ID
  # Create application object and embed the details
  features {}
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
}


resource "azurerm_service_plan" "plan787878" {
  name                = "plan787878"
  resource_group_name = "template-rg"
  location            = "North Europe"
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_web_app" "newapp1002030" {
  name                = "newapp1002090630"
  resource_group_name = "template-rg"
  location            = "North Europe"
  service_plan_id     = azurerm_service_plan.plan787878.id

  site_config {
    always_on = false
    application_stack{
        current_stack="dotnet"
        dotnet_version="v6.0"
    }
  }

  depends_on = [
    azurerm_service_plan.plan787878
  ]
}

resource "azurerm_mssql_server" "sqlserver46" {
  name                         = "sqlserver468699ty85656"
  resource_group_name          = "template-rg"
  location                     = "North Europe"
  version                      = "12.0"
  administrator_login          = "sqlusr"
  administrator_login_password = ""  
}

resource "azurerm_mssql_database" "boniton" {
  name           = "boniton"
  server_id      = azurerm_mssql_server.sqlserver46.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  depends_on     = [
    azurerm_mssql_server.sqlserver46
  ]
}
  