 ## inteface pour la machine WEB
resource "azurerm_network_interface" "web_Prod_01_nic" {
    name                        = "web_Dev_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "web_Prod_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Prod_Subnet.id
        private_ip_address_allocation 	= "static"
	private_ip_address 		= "10.0.1.10"
        public_ip_address_id          	= azurerm_public_ip.Prod_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "web_Prod_nsg_Association" {
    network_interface_id      = azurerm_network_interface.web_Prod_01_nic.id
    network_security_group_id = azurerm_network_security_group.web_Prod_nsg.id
}

 ## inteface pour la machine App
resource "azurerm_network_interface" "Prod_App_01_nic" {
    name                        = "Prod_App_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "Prod_App_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Prod_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "10.0.1.11"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "App_Prod_nsg_Association" {
    network_interface_id      = azurerm_network_interface.Prod_App_01_nic.id
    network_security_group_id = azurerm_network_security_group.Prod_App_nsg.id
}


 ## inteface pour la machine Bdd
resource "azurerm_network_interface" "Prod_Bdd_01_nic" {
    name                        = "Prod_Bdd_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "Prod_Bdd_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Prod_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "10.0.1.12"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "Bdd_Prod_nsg_Association" {
    network_interface_id      = azurerm_network_interface.Prod_Bdd_01_nic.id
    network_security_group_id = azurerm_network_security_group.Prod_Bdd_nsg.id
}
