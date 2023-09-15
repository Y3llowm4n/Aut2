resource "azurerm_linux_virtual_machine" "lin_web_vm" {
  name                = "linuxwebvm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1ls"
  computer_name       = var.computer_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.lin_web_nic1.id]

admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.linux_key.public_key_openssh
  }

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

   boot_diagnostics {
    storage_account_uri = azurerm_storage_account.st_ass_lin_001.primary_blob_endpoint
  }

  depends_on = [ tls_private_key.linux_key ]

}

resource "azurerm_virtual_machine_extension" "vm_ext_bash" {
  name                 = "vme-bash"
  virtual_machine_id   = azurerm_linux_virtual_machine.lin_web_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "fileUris": ["https://stasslin01.blob.core.windows.net/stcasslin01/website.sh"], 
    "commandToExecute": "bash website.sh" 
  }
    SETTINGS
}