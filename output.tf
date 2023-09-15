output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "blob_url" {
  value = azurerm_storage_blob.bb_lin_001.url
}