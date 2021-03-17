# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "deploygroup" {
    name     = "deployResourceGroup"
    location = "eastus"
}
# Create virtual network
resource "azurerm_virtual_network" "deploynetwork" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    address_space       = ["192.168.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.deploygroup.name

}
# Create subnet
resource "azurerm_subnet" "deploysubnet" {
    name                 = "deploySubnet"
    resource_group_name  = azurerm_resource_group.deploygroup.name
    virtual_network_name = azurerm_virtual_network.deploynetwork.name
    address_prefixes       = ["10.0.0.0/16"]
    address_prefixes       = ["192.168.0.0/16"]
}

# Create public IPs
resource "azurerm_public_ip" "deploypublicip" {
    name                         = "deployPublicIP"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.deploygroup.name
    allocation_method            = "Dynamic"
}
# Create Network Security Group and rule
resource "azurerm_network_security_group" "deploynsg" {
    name                = "deployNetworkSecurityGroup"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.deploygroup.name
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
# Create network interface
resource "azurerm_network_interface" "deploynic" {
    name                      = "deployNIC"
    location                  = "eastus"
    resource_group_name       = azurerm_resource_group.deploygroup.name
    ip_configuration {
        name                          = "deployNicConfiguration"
        subnet_id                     = azurerm_subnet.deploysubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.deploypublicip.id
    }
}
# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "deployNsgAss" {
    network_interface_id      = azurerm_network_interface.deploynic.id
    network_security_group_id = azurerm_network_security_group.deploynsg.id
}
# Create (and display) an SSH key
resource "tls_private_key" "deploypublic_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { value = tls_private_key.deploypublic_ssh.private_key_pem }
# Create virtual machine
resource "azurerm_linux_virtual_machine" "deployvm" {
    name                  = "deployVM"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.deploygroup.name
    network_interface_ids = [azurerm_network_interface.deploynic.id]
    size                  = "Standard_DS1_v2"
    os_disk {
        name              = "deployOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    computer_name  = "deployvm"
    admin_username = "azureuser"
    disable_password_authentication = true
    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.deploypublic_ssh.public_key_openssh
    }
}
