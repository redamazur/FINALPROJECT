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

resource "azurerm_network_security_group" "Dev_App_nsg" {
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

resource "azurerm_network_security_group" "Dev_Bdd_nsg" {
    name                = "Bdd_dev_NetworkSecurityGroup"
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

}