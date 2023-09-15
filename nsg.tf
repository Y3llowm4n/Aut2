resource "azurerm_network_security_group" "nsg_lin_web_1" {
  name                = "nsg_lin_web_1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

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

  security_rule {
    name                       = "HTTPS"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  count = var.count_vm
  network_interface_id      = azurerm_network_interface.lin_web_nic1[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg_lin_web_1.id
}