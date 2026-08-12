
# data "azurerm_virtual_network" "dvnet" {
#     for_each = var.datasubnet
#   name                = each.value.virtual_network_name
#   resource_group_name = each.value.resource_group_name
# }

resource "azurerm_subnet" "datasubnet"{
    for_each = var.datasubnet
    name=each.value.name
    #resource_group_name = data.azurerm_virtual_network.dvnet[each.key].resource_group_name
    #virtual_network_name=data.azurerm_virtual_network.dvnet[each.key].name
    address_prefixes=each.value.address_prefix
    resource_group_name = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name

}