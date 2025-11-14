output "key_vault_secret_ids" {
  description = "IDs of the created Key Vault Secrets."
  value = { for k, v in azurerm_key_vault_secret.key_vault_secret : k => v.id }
}

output "key_vault_secret_names" {
  description = "Names of the Key Vault Secrets."
  value = { for k, v in azurerm_key_vault_secret.key_vault_secret : k => v.name }
}
