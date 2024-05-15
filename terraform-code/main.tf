terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {

  }
}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}


data "azurerm_resource_group" "rg" {
  name     = "demowebapprg"
}

data "azurerm_service_plan" "service_plan" {
  name                = "demowebappava"
  resource_group_name = "demowebapprg"
}

resource "azurerm_linux_web_app" "example" {
  name                = "demovjavawebapp"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = data.azurerm_service_plan.service_plan.id
  public_network_access_enabled = false

  site_config {

    application_stack {
      java_version         = "17"
      java_server          = "JAVA"
      java_server_version  = "17"
    }
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "webapp-pip"
  sku                 = "Standard"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  depends_on = [data.azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "mydomain.com"
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [data.azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_associate" {
  name                  = "test"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = "/subscriptions/7db47fd7-88a3-4d98-ad97-f89dce724605/resourceGroups/demowebapprg/providers/Microsoft.Network/virtualNetworks/demovnet"
}

resource "azurerm_private_endpoint" "demowebapppvp" {
  name                = "demowebapppvp"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = "/subscriptions/7db47fd7-88a3-4d98-ad97-f89dce724605/resourceGroups/demowebapprg/providers/Microsoft.Network/virtualNetworks/demovnet/subnets/default"
  
  private_service_connection {
    name                           = "webapp-privateserviceconnection"
    private_connection_resource_id = azurerm_linux_web_app.example.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  depends_on = [azurerm_private_dns_zone.private_dns_zone,data.azurerm_resource_group.rg]
}