data "azurerm_virtual_network" "Final_Network" {
    name                = "myVnet"
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
}

resource "azurerm_subnet" "Dev_Subnet"{
    name                 = "Dev_Subnet"
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
    virtual_network_name = data.azurerm_virtual_network.Final_Network.name
    address_prefixes       = ["10.0.1.0/24"]
}
