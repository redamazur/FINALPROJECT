resource "tls_private_key" "Dev_Web_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

output "tls_private_key" { value = tls_private_key.Dev_Web_ssh.private_key_pem }

###################################

resource "random_id" "Dev-randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.rg_Dev.name
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "Dev-Storage" {
    name                        = "diag${randomId.Dev-randomId.hex}"
    location                    = azurerm_resource_group.rg_Dev.location
    resource_group_name         = azurerm_resource_group.rg_Dev.name
    account_tier                = "Standard"
#    account_replication_type    = "LRS"

    tags = {
        environment = "Terraform Demo"
    }
}


##################################




resource "azurerm_linux_virtual_machine" "Dev-Web-vm" {
    name                  = "Dev-Web-VM"
    location              = azurerm_resource_group.rg_Dev.location
    resource_group_name   = azurerm_resource_group.rg_Dev.name
    network_interface_ids = [azurerm_network_interface.web_Dev_01_nic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "Web-Dev-Disk"
        caching           = "ReadWrite"
        # storage_account_type = "Premium_LRS"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "Dev-Web-vm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.Dev_Web_ssh.public_key_openssh
    }



    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.Dev_Storage.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}