variable "vnets" {
  type = map(object({
    nsg_name            = string
    
    location            = string
    resource_group_name = string

    # ----- Optional arguments -----

    security_rule = optional(map(object({
      security_rule_name         = string
      protocol                   = string
      priority                   = number
      direction                  = string
      access                     = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })))

    vnet_name     = string
    address_space = optional(list(string))
    dns_servers   = optional(list(string))
    subnets = optional(list(object({
      subnet_name      = string
      address_prefixes = list(string)
      security_group   = optional(string)
    })))
    tags = optional(map(string))
  }))
}
