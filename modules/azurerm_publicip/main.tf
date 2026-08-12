# data "azurerm_resource_group" "drg" {
#   for_each = var.public_ip
#   name = each.value.resource_group_name
# }

resource "azurerm_public_ip" "public_ip"{
    for_each=var.public_ip
    name=each.value.name
    location=each.value.location
    #resource_group_name = data.azurerm_resource_group.drg[each.key].name
    allocation_method=each.value.allocation_method
    resource_group_name = each.value.resource_group_name
}

    
    