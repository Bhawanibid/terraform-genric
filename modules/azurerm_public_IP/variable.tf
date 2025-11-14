variable "pips" {
  description = "Map of Public IP configurations."
  type = map(object({
    # ---------- Required ----------
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    # ---------- Optional ----------
    zones                    = optional(list(string))
    ddos_protection_mode      = optional(string)
    ddos_protection_plan_id   = optional(string)
    domain_name_label         = optional(string)
    domain_name_label_scope   = optional(string)
    edge_zone                 = optional(string)
    idle_timeout_in_minutes   = optional(number)
    ip_tags                   = optional(map(string))
    ip_version                = optional(string)
    public_ip_prefix_id       = optional(string)
    reverse_fqdn              = optional(string)
    sku                       = optional(string)
    sku_tier                  = optional(string)
    tags                      = optional(map(string))
  }))
}
