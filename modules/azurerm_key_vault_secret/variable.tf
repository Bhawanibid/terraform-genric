variable "key_vault_secrets" {
  description = "Map of Key Vault Secrets configuration."
  type = map(object({
    # ---------- Required ----------
    name                = string
    key_vault_name      = string
    resource_group_name = string

    # ---------- Optional ----------
    value            = optional(string)
    value_wo         = optional(string)
    value_wo_version = optional(number)
    content_type     = optional(string)
    not_before_date  = optional(string)
    expiration_date  = optional(string)
    tags             = optional(map(string))
  }))
}
