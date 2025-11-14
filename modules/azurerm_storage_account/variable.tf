variable "stg" {
  type = map(object({
    # --- Required Fields ---
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # --- Optional Fields ---
    tags                            = optional(map(string), {})
    account_kind                    = optional(string, "StorageV2")
    access_tier                     = optional(string, "Hot")
    min_tls_version                 = optional(string, "TLS1_2")
    allow_nested_items_to_be_public = optional(bool, false)
    shared_access_key_enabled       = optional(bool, true)
    default_to_oauth_authentication = optional(bool, false)
    is_hns_enabled                  = optional(bool, false)
    nfsv3_enabled                   = optional(bool, false)
    large_file_share_enabled        = optional(bool, false)
    public_network_access_enabled   = optional(bool, true)

  }))
}
