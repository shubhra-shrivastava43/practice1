
data "azurerm_subnet" "subnet1"{
    for_each = var.VM
    name=each.value.subnet_name
    resource_group_name = each.value.resource_group_name
    virtual_network_name = each.value.virtualnetworkname
}

data "azurerm_public_ip" "pip" {
    for_each = var.VM
  name                = each.value.public_ip_address_name
  resource_group_name = each.value.resource_group_name
}


data "azurerm_key_vault" "KV" {
  for_each = var.VM
  name                = each.value.keyvalut_name
  resource_group_name =each.value.resource_group_name
}


data "azurerm_key_vault_secret" "username" {
  for_each = var.VM
  name         = each.value.vm-username
  key_vault_id = data.azurerm_key_vault.KV[each.key].id
}

data "azurerm_key_vault_secret" "password" {
  for_each = var.VM
  name         = each.value.vm-password
  key_vault_id = data.azurerm_key_vault.KV[each.key].id
}


resource "azurerm_network_interface" "nic"{
  for_each = var.VM
    name=each.value.nicname
    location =each.value.location
    resource_group_name = each.value.resource_group_name
    ip_configuration {
      name="dhondu"
      private_ip_address_allocation = each.value.private_ip_address_allocation
      public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
      subnet_id = data.azurerm_subnet.subnet1[each.key].id
      
      
    }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each=var.VM
  name  =each.value.vm_name
  resource_group_name =each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = data.azurerm_key_vault_secret.username[each.key].value
  admin_password =data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

 
}