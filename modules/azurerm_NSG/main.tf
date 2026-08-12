

resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsg
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

data "azurerm_subnet" "subnet1"{
    for_each = var.nsg
    name=each.value.subnet_name
    resource_group_name = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  for_each = var.nsg
  subnet_id                 = data.azurerm_subnet.subnet1[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}