
# data "azurerm_key_vault" "KV" {
#   name                = "mykeyvault"
#   resource_group_name ="rg-chor"
# }

# resource "azurerm_key_vault_secret" "vm_password" {
#   name         = "vm-admin-password"
#   value        = "Shubhra@2026"
#   key_vault_id = data.azurerm_key_vault.KV.id
# }



