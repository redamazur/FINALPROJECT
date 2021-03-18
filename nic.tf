 ## inteface pour la machine WEB
resource "azurerm_network_interface" "web_Dev_01_nic" {
    name                        = "web_Dev_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "web_Dev_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	private_ip_address 		= "10.0.2.10"
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
resource "azurerm_network_interface" "Dev_App_01_nic" {
    name                        = "Dev_App_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "Dev_App_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "10.0.2.11"
#        public_ip_address_id          	= azurerm_public_ip.Dev_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "App_dev_nsg_Association" {
    network_interface_id      = azurerm_network_interface.Dev_App_01_nic.id
    network_security_group_id = azurerm_network_security_group.Dev_App_nsg.id
}


 ## inteface pour la machine App
resource "azurerm_network_interface" "Dev_Bdd_01_nic" {
    name                        = "Dev_Bdd_01_nic"
    location                    = data.azurerm_resource_group.rg_Dev.location
    resource_group_name         = data.azurerm_resource_group.rg_Dev.name

    ip_configuration {
        name                          	= "Dev_Bdd_01_nic_Configuration"
        subnet_id                     	= data.azurerm_subnet.Dev_Subnet.id
        private_ip_address_allocation 	= "static"
	    private_ip_address 		        = "10.0.2.12"
#        public_ip_address_id          	= azurerm_public_ip.Dev_publicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "Bdd_dev_nsg_Association" {
    network_interface_id      = azurerm_network_interface.Dev_Bdd_01_nic.id
    network_security_group_id = azurerm_network_security_group.Dev_Bdd_nsg.id
}
