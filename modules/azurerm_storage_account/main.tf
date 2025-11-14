resource "azurerm_storage_account" "storage_account" {
  for_each                        = var.stg
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  account_tier                    = each.value.account_tier
  account_replication_type        = each.value.account_replication_type

  # --- Optional Fields ---
  tags                            = each.value.tags
  account_kind                    = each.value.account_kind
  access_tier                     = each.value.access_tier
  min_tls_version                 = each.value.min_tls_version
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  default_to_oauth_authentication = each.value.default_to_oauth_authentication
  is_hns_enabled                  = each.value.is_hns_enabled
  nfsv3_enabled                   = each.value.nfsv3_enabled
  large_file_share_enabled        = each.value.large_file_share_enabled
  public_network_access_enabled   = each.value.public_network_access_enabled

}
