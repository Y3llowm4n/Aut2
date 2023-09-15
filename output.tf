output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = [for vm in azurerm_linux_virtual_machine.lin_web_vm : vm.public_ip_address]
}

output "blob_url" {
  value = azurerm_storage_blob.bb_lin_001.url
}