data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vaults" {
  for_each = var.key_vaults

  # ---------- Required arguments ----------
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = each.value.sku_name

  # ---------- Optional arguments ----------
  enabled_for_deployment          = lookup(each.value, "enabled_for_deployment", null)
  enabled_for_disk_encryption     = lookup(each.value, "enabled_for_disk_encryption", null)
  enabled_for_template_deployment = lookup(each.value, "enabled_for_template_deployment", null)
  rbac_authorization_enabled      = lookup(each.value, "rbac_authorization_enabled", null)
  purge_protection_enabled        = lookup(each.value, "purge_protection_enabled", null)
  public_network_access_enabled   = lookup(each.value, "public_network_access_enabled", null)
  soft_delete_retention_days      = lookup(each.value, "soft_delete_retention_days", null)
  tags                            = lookup(each.value, "tags", null)

  # ---------- Access Policies (Optional block) ----------
  dynamic "access_policy" {
    for_each = lookup(each.value, "access_policy", [])
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = data.azurerm_client_config.current.object_id
      application_id          = lookup(access_policy.value, "application_id", null)
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", null)
      key_permissions         = lookup(access_policy.value, "key_permissions", null)
      secret_permissions      = lookup(access_policy.value, "secret_permissions", null)
      storage_permissions     = lookup(access_policy.value, "storage_permissions", null)
    }
  }

  # ---------- Network ACLs (Optional block) ----------
  dynamic "network_acls" {
    for_each = each.value.network_acls == null ? [] : [each.value.network_acls]
    content {
      bypass                     = lookup(network_acls.value, "bypass" , null)
      default_action             = lookup(network_acls.value, "default_action", null)
      ip_rules                   = lookup(network_acls.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_acls.value, "virtual_network_subnet_ids", null)
    }
  }
}
