resource "azurerm_resource_group" "datarg"{
    for_each=var.datarg
    name=each.value.name
    location=each.value.location
}