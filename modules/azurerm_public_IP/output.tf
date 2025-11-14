output "public_ip_ids" {
  description = "IDs of created Public IPs"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.id }
}

output "public_ip_addresses" {
  description = "Actual IP addresses assigned"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.ip_address }
}

output "public_ip_fqdns" {
  description = "FQDNs of created Public IPs (if applicable)"
  value       = { for k, v in azurerm_public_ip.public_ip : k => v.fqdn }
}
