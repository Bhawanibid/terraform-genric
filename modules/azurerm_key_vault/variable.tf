variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type = map(object({
    # ---------- Required ----------
    name                = string
    location            = string
    resource_group_name = string
    # tenant_id           = string
    sku_name            = string

    # ---------- Optional ----------
    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    rbac_authorization_enabled      = optional(bool)
    purge_protection_enabled        = optional(bool)
    public_network_access_enabled   = optional(bool)
    soft_delete_retention_days      = optional(number)
    tags                            = optional(map(string))

    # ---------- Optional Blocks ----------
    access_policy = optional(list(object({
    #   tenant_id               = optional(string)
    #   object_id               = optional(string)
      application_id          = optional(string)
      certificate_permissions = optional(list(string))
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      storage_permissions     = optional(list(string))
    })))

    network_acls = optional(list(object({
      bypass                     = optional(string)
      default_action             = optional(string)
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    })))
  }))
}
