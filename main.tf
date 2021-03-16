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


resource "azurerm_resource_group" "rg_Dev" {
  name = "FINAL_PROJECT_EP_RB_Dev" 
  location = "westeurope"
}

resource "azurerm_virtual_network" "Final_Network" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg_Dev.location
    resource_group_name = azurerm_resource_group.rg_Dev.name
    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_subnet" "Dev-Subnet"{
    name                 = "myVnet"
    resource_group_name  = azurerm_resource_group.rg_Dev.name
    virtual_network_name = azurerm_virtual_network.Final_Network.name
    address_prefixes       = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "Dev_publicip" {
    name                 = "myPublicIP"
    location             = azurerm_resource_group.rg_Dev.location
    resource_group_name  = azurerm_resource_group.rg_Dev.name
    allocation_method    = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}



