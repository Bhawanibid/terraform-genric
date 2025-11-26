resource "azurerm_container_registry" "acr" {
  for_each = var.acr_configs

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
  tags                = try(each.value.tags,{})

  # Optional: Network Rule Set
  dynamic "network_rule_set" {
    for_each = lookup(each.value, "network_rule_set", null) == null ? [] : [each.value.network_rule_set]

    content {
      default_action = network_rule_set.value.default_action

      dynamic "ip_rule" {
        for_each = lookup(network_rule_set.value,"ip_rule",[])
        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }
    }
  }

  # Optional: Georeplications
  dynamic "georeplications" {
    for_each = lookup(each.value, "georeplications",[])

    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled,false)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled,false)
      tags                      = try(georeplications.value.tags,{})
    }
  }
}
