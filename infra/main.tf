terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg-labs-u2-proyectos-jf" {
  name     = "rg-labs-u2-proyectos-jf"
  location = "East US 2"
}

resource "azurerm_mssql_server" "labs-u2-proyectos-jf" {
  name                         = "labs-u2-proyectos-jf"
  resource_group_name          = azurerm_resource_group.rg-labs-u2-proyectos-jf.name
  location                     = azurerm_resource_group.rg-labs-u2-proyectos-jf.location
  version                      = "12.0"
  administrator_login          = var.sqladmin_username
  administrator_login_password = var.sqladmin_password

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "db_modelo01" {
  name                        = "modelo01"
  server_id                   = azurerm_mssql_server.labs-u2-proyectos-jf.id
  sku_name                    = "GP_S_Gen5_2"
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  storage_account_type        = "Local"
}

resource "azurerm_mssql_database" "db_modelo02" {
  name                        = "modelo02"
  server_id                   = azurerm_mssql_server.labs-u2-proyectos-jf.id
  sku_name                    = "GP_S_Gen5_2"
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  storage_account_type        = "Local"
}

resource "azurerm_mssql_database" "db_modelo03" {
  name                        = "modelo03"
  server_id                   = azurerm_mssql_server.labs-u2-proyectos-jf.id
  sku_name                    = "GP_S_Gen5_2"
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  storage_account_type        = "Local"
}

resource "azurerm_mssql_firewall_rule" "allow-azure-services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.labs-u2-proyectos-jf.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}
