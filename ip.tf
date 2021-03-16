resource "azurerm_public_ip" "Dev_publicip" {
    name                 = "Dev_PublicIP"
    location             = azurerm_resource_group.rg_Dev.location
    resource_group_name  = azurerm_resource_group.rg_Dev.name
    allocation_method    = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}
