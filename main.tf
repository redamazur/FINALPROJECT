terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.51.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}


resource "azurerm_resource_group" "rg" {
  name = "RG_DEV2"
  location = "westus"
}

resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnetDEV"
    address_space       = ["10.0.0.0/16"]
    location            = "westus"
#    resource_group_name = "RG_DEV2"
    resource_group_name = azurerm_resource_group.rg.name
    tags = {
        environment = "Terraform Demo"
    }
}
