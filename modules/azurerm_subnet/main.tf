resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  # ---------- Required Arguments ----------
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

  # ---------- Optional Arguments ----------
  address_prefixes                              = lookup(each.value, "address_prefixes", null)
  default_outbound_access_enabled               = lookup(each.value, "default_outbound_access_enabled", null)
  private_endpoint_network_policies             = lookup(each.value, "private_endpoint_network_policies", null)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)
  sharing_scope                                 = lookup(each.value, "sharing_scope", null)
  service_endpoints                             = lookup(each.value, "service_endpoints", null)
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", null)
  
  # ---------- Optional ip_address_pool block ----------
  dynamic "ip_address_pool" {
    for_each = lookup(each.value, "ip_address_pool", null) == null ? [] : [each.value.ip_address_pool]
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  # ---------- Optional delegation block ----------
  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", null) == null ? [] : [each.value.delegation]
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = lookup(delegation.value, "service_delegation", null) == null ? [] : [delegation.value.service_delegation]
        content {
          name    = service_delegation.value.name
          actions = lookup(service_delegation.value, "actions", null)
        }
      }
    }
  }
}
