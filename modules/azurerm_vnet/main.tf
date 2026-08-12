
# data "azurerm_resource_group" "drg" {
#   for_each = var.datavnet
#   name = each.value.resource_group_name
# }

resource "azurerm_virtual_network" "datavnet"{
    for_each = var.datavnet
    name=each.value.name
    location=each.value.location
   # resource_group_name = data.azurerm_resource_group.drg[each.key].name
    address_space = each.value.address_space
    resource_group_name = each.value.resource_group_name

}