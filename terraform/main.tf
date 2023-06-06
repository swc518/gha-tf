terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.59.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "example_rg"
    storage_account_name = "example_storage_account"
    container_name       = "example_container"
    key                  = "example_container.tfstate"
  }
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "example_rg" {
  name     = "example_rg"
  location = "westus2"
}

#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "westus2"
  resource_group_name = azurerm_resource_group.example_rg.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}
  