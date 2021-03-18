resource "azurerm_public_ip" "Prod_publicip" {
    name                 = "Prod_PublicIP"
    location             = data.azurerm_resource_group.rg_Dev.location
    resource_group_name  = data.azurerm_resource_group.rg_Dev.name
    allocation_method    = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}
