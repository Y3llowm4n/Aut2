resource "azurerm_network_interface" "lin_web_nic1" {
  name                = "nic_lin_web"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                          = "nic_lin_config"
    subnet_id                     = azurerm_subnet.lin_sub_web.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.1.10"
    public_ip_address_id          = azurerm_public_ip.lin_web_ip_1.id

  }
  
}