resource "azurerm_storage_account" "st_ass_lin_001" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "ct_ass_lin_001" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.st_ass_lin_001.name
  container_access_type = "container" # "blob" "private"
}
