data "azurerm_client_config" "current" {}

resource "azurerm_mssql_server" "sql_server" {
  for_each = var.sql_servers

  # ---------------- Required Arguments ----------------
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  version             = each.value.version

  # ---------------- Optional Arguments ----------------
  administrator_login                          = data.azurerm_key_vault_secret.sql-user[each.key].value
  administrator_login_password                 = data.azurerm_key_vault_secret.sql-password[each.key].value
  administrator_login_password_wo              = lookup(each.value, "administrator_login_password_wo", null)
  administrator_login_password_wo_version      = lookup(each.value, "administrator_login_password_wo_version", null)
  connection_policy                            = lookup(each.value, "connection_policy", null)
  express_vulnerability_assessment_enabled     = lookup(each.value, "express_vulnerability_assessment_enabled", null)
  transparent_data_encryption_key_vault_key_id = lookup(each.value, "transparent_data_encryption_key_vault_key_id", null)
  minimum_tls_version                          = lookup(each.value, "minimum_tls_version", "1.2")
  public_network_access_enabled                = lookup(each.value, "public_network_access_enabled", true)
  outbound_network_restriction_enabled         = lookup(each.value, "outbound_network_restriction_enabled", false)
  primary_user_assigned_identity_id            = lookup(each.value, "primary_user_assigned_identity_id", null)
  tags                                         = lookup(each.value, "tags", {})

  # ---------------- Azure AD Administrator Block (Optional) ----------------
  dynamic "azuread_administrator" {
    for_each = lookup(each.value, "azuread_administrator", []) == [] ? [] : [lookup(each.value, "azuread_administrator", {})]
    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = data.azurerm_client_config.current.object_id
      tenant_id                   = data.azurerm_client_config.current.tenant_id
      azuread_authentication_only = lookup(azuread_administrator.value, "azuread_authentication_only", null)
    }
  }

  # ---------------- Identity Block (Optional) ----------------
  dynamic "identity" {
    for_each = lookup(each.value, "identity", []) == [] ? [] : [lookup(each.value, "identity", {})]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
}
