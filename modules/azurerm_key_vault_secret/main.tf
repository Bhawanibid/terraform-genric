resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = var.key_vault_secrets

  # ---------- Required Arguments ----------
  name         = each.value.name
  key_vault_id = data.azurerm_key_vault.key_vaults[each.key].id

  # ---------- One of 'value' or 'value_wo' is required ----------
  value        = lookup(each.value, "value", null)
  value_wo     = lookup(each.value, "value_wo", null)

  # ---------- Optional Arguments ----------
  value_wo_version = lookup(each.value, "value_wo_version", null)
  content_type     = lookup(each.value, "content_type", null)
  not_before_date  = lookup(each.value, "not_before_date", null)
  expiration_date  = lookup(each.value, "expiration_date", null)
  tags             = lookup(each.value, "tags", null)
}
