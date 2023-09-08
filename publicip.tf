resource "azurerm_public_ip" "lin_web_ip_1" {
  name                = "lin_web_ip_1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

