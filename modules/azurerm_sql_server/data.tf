data "azurerm_key_vault" "key_vaults" {
  for_each            = var.sql_servers
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_key_vault_secret" "sql-user" {
  for_each     = var.sql_servers
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.key_vaults[each.key].id
}

data "azurerm_key_vault_secret" "sql-password" {
  for_each     = var.sql_servers
  name         = each.value.secret_password
  key_vault_id = data.azurerm_key_vault.key_vaults[each.key].id
}
