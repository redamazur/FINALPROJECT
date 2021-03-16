 ## inteface pour la machine WEB
resource "azurerm_network_interface" "web_Dev_01_nic" {
    name                        = "web_Dev_01_nic"
    location                    = azurerm_resource_group.rg_Dev.location
    resource_group_name         = azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "web_Dev_01_nic_Configuration"
        subnet_id                     	= azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "192.168.1.10"
        public_ip_address_id          	= azurerm_public_ip.Dev_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "web_dev_nsg_Association" {
    network_interface_id      = azurerm_network_interface.web_Dev_01_nic.id
    network_security_group_id = azurerm_network_security_group.web_dev_nsg.id
}

 ## inteface pour la machine App
resource "azurerm_network_interface" "App_Dev_01_nic" {
    name                        = "App_Dev_01_nic"
    location                    = azurerm_resource_group.rg_Dev.location
    resource_group_name         = azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "App_Dev_01_nic_Configuration"
        subnet_id                     	= azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "192.168.1.11"
#        public_ip_address_id          	= azurerm_public_ip.Dev_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "App_dev_nsg_Association" {
    network_interface_id      = azurerm_network_interface.App_Dev_01_nic.id
    network_security_group_id = azurerm_network_security_group.App_dev_nsg.id
}