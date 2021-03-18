data "azurerm_virtual_network" "Final_Network" {
    name                = "myVnet"
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
}

data "azurerm_subnet" "Dev_Subnet" {
    name                = "deployDevsubnet"
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
    virtual_network_name = data.azurerm_virtual_network.Final_Network.name 
}

data "azurerm_subnet" "Prod_Subnet" {
    name                = "deployProdsubnet"
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
    virtual_network_name = data.azurerm_virtual_network.Final_Network.name 
}
