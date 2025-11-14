output "subnet_ids" {
  description = "Map of subnet IDs"
  value = { for k, s in azurerm_subnet.subnet : k => s.id }
}
