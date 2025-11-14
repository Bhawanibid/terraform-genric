variable "subnets" {
  description = "Map of subnet configurations."
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string

    # ---------- Optional Arguments ----------
    address_prefixes                              = optional(list(string))
    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    tags                                          = optional(map(string))

    # ---------- Optional ip_address_pool Block ----------
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))

    # ---------- Optional delegation Block ----------
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))
  }))
}
