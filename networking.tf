resource "azurerm_virtual_network" "lin_vn_web1" {
  name                = "lin_web_vn1"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "lin_sub_web" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.lin_vn_web1.name
  address_prefixes     = ["10.10.1.0/24"]
}