
data "azurerm_client_config" "info" {}

resource "azurerm_key_vault" "kv" {
  for_each = var.kv
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tenant_id = data.azurerm_client_config.info.tenant_id
  sku_name  = "standard"

  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  # rbac_authorization_enabled = true ;#jb rbac use krenge tb likhna hota hai 
}
# resource "azurerm_role_assignment" "kv_admin" {

#   for_each = var.kv

#   scope = azurerm_key_vault.kv[each.key].id

#   role_definition_name = "Key Vault Administrator"

#   principal_id = data.azurerm_client_config.info.object_id
# }

resource "azurerm_key_vault_access_policy" "policy" {

  for_each = var.kv

  key_vault_id = azurerm_key_vault.kv[each.key].id

  tenant_id = data.azurerm_client_config.info.tenant_id
  object_id = data.azurerm_client_config.info.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Purge"
  ]
}
resource "azurerm_key_vault_secret" "username" {
  for_each = var.kv
  # depends_on = [
  #   azurerm_role_assignment.kv_admin
  # ]

  depends_on = [
  azurerm_key_vault_access_policy.policy
]


  name         = "vm-username"
  value        = each.value.username
  key_vault_id = azurerm_key_vault.kv[each.key].id
}


resource "azurerm_key_vault_secret" "password" {
  for_each = var.kv
  # depends_on = [
  #   azurerm_role_assignment.kv_admin
  # ]
depends_on = [
  azurerm_key_vault_access_policy.policy
]
  
  name         = "vm-password"
  value        = each.value.password
  key_vault_id = azurerm_key_vault.kv[each.key].id
}


# resource "azurerm_key_vault_secret" "username" {
#   for_each = var.username

#   name         = "vm-username"
#   value        = each.value.username
#   key_vault_id = azurerm_key_vault.kv[each.key].id
# }


# resource "azurerm_key_vault_secret" "password" {
#   for_each = var.password
  
#   name         = "vm-password"
#   value        = each.value.password
#   key_vault_id = azurerm_key_vault.kv[each.key].id
# }




# azurerm_client_config kya hai?

# Ye Azure Provider ka ek built-in data source hai.

# Ye batata hai:

# Kaun login hai?
# Kis Subscription me ho?
# Tenant ID kya hai?
# Client ID kya hai?