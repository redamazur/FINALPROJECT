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
    address_space       = ["192.168.0.0/16"]
    location            = azurerm_resource_group.rg_Dev.location
    resource_group_name = azurerm_resource_group.rg_Dev.name
    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_subnet" "Dev_Subnet"{
    name                 = "myVnet"
    resource_group_name  = azurerm_resource_group.rg_Dev.name
    virtual_network_name = azurerm_virtual_network.Final_Network.name
    address_prefixes       = ["192.168.1.0/24"]
}

resource "azurerm_public_ip" "Dev_publicip" {
    name                 = "Dev_PublicIP"
    location             = azurerm_resource_group.rg_Dev.location
    resource_group_name  = azurerm_resource_group.rg_Dev.name
    allocation_method    = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_security_group" "web_dev_nsg" {
    name                = "web_dev_NetworkSecurityGroup"
    location            = azurerm_resource_group.rg_Dev.location
    resource_group_name = azurerm_resource_group.rg_Dev.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "http"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "web_Dev_01_nic" {
    name                        = "web_Dev_01_nic"
    location                    = azurerm_resource_group.rg_Dev.location
    resource_group_name         = azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "web_Dev_01_nic_Configuration"
        subnet_id                     	= azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	private_ip_address 		= "192.168.1.10"
        public_ip_address_id          	= azurerm_public_ip.Dev_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.web_Dev_01_nic.id
    network_security_group_id = azurerm_network_security_group.web_dev_nsg.id
}


