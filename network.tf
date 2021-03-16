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
