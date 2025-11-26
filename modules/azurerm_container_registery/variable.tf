variable "acr_configs" {
  description = "Map of ACR configuration"
  type = map(object({
    name                = string                # Required
    resource_group_name = string                # Required
    location            = string                # Required
    sku                 = string                # Required
    admin_enabled       = optional(bool, false) # Optional
    tags                = optional(map(string), {})

    # Optional Blocks
    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool, false)
      zone_redundancy_enabled   = optional(bool, false)
      tags                      = optional(map(string), {})
    })), [])

    network_rule_set = optional(object({
      default_action = optional(string, "Allow")
      ip_rule = optional(list(object({
        action   = string
        ip_range = string
      })), [])
    }))
  }))
}
