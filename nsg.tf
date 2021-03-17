resource "azurerm_network_security_group" "web_dev_nsg" {
    name                = "dev_web_NetworkSecurityGroup"
    location            = data.azurerm_resource_group.rg_Dev.location
    resource_group_name = data.azurerm_resource_group.rg_Dev.name

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
    name                = "dev_App_NetworkSecurityGroup"
    location            = data.azurerm_resource_group.rg_Dev.location
    resource_group_name = data.azurerm_resource_group.rg_Dev.name

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
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    tags = {
        environment = "Terraform Demo"
    }

}

resource "azurerm_network_security_group" "Dev_Bdd_nsg" {
    name                = "dev_Bdd_NetworkSecurityGroup"
    location            = data.azurerm_resource_group.rg_Dev.location
    resource_group_name = data.azurerm_resource_group.rg_Dev.name

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
        name                       = "data"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
