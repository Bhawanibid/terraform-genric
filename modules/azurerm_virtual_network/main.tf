resource "azurerm_network_security_group" "network_security" {
  for_each            = var.vnets
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # ----- Optional arguments -----
  tags = lookup(each.value, "tags", null)


  dynamic "security_rule" {
    for_each = lookup(each.value, "security_rule", null) # (Block hota hai - isliye ignore krna h to hata dena)
    content {
      name                       = security_rule.value.security_rule_name
      protocol                   = security_rule.value.protocol
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}


resource "azurerm_virtual_network" "virtual_network" {
  for_each            = var.vnets
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

  dynamic "subnet" {
    for_each = each.value.subnets == null ? [] : each.value.subnets
    content {
      name             = subnet.value.subnet_name
      address_prefixes = subnet.value.address_prefixes
      security_group = lookup(subnet.value, "security_group", null) != null ? azurerm_network_security_group.network_security[each.key].id : null

    }
  }
  tags = each.value.tags


}
