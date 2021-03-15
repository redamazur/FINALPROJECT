# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "RG_DEV" {
  name     = "RG_DEV"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "NETWORK_DEV" {
  name                = "NETWORK_DEV"
  resource_group_name = "soutenance_azure_RBEP"
  location            = "West Europe"
  address_space       = ["10.0.0.0/16"]
}