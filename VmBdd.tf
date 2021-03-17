resource "azurerm_linux_virtual_machine" "Dev-Bdd-vm" {
    name                  = "Dev-Bdd-VM"
    location              = data.azurerm_resource_group.rg_Dev.location
    resource_group_name   = data.azurerm_resource_group.rg_Dev.name
    network_interface_ids = [azurerm_network_interface.Dev_Bdd_01_nic.id]
    size                  = "Standard_B1ms"

    os_disk {
        name              = "Dev-Bdd-Disk"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "Dev-Bdd-vm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.Dev_Web_ssh.public_key_openssh
    }



#    boot_diagnostics {
#        storage_account_uri = azurerm_storage_account.Dev_Storage.primary_blob_endpoint
#    }

    tags = {
        environment = "Terraform Demo"
    }
}
