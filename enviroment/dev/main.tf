module "rg" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "stgs" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_storage_account"
  stg        = var.stg
}

module "nsgs-vnet" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets

}

module "subnets-optional" {
  depends_on = [module.rg, module.nsgs-vnet]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
}

module "public-ip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_IP"
  pips       = var.pips
}

module "vm" {
  depends_on = [module.rg, module.public-ip, module.subnets-optional]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}

module "sql-server" {
  depends_on  = [module.rg]
  source      = "../../modules/azurerm_sql_server"
  sql_servers = var.sql_servers
}

module "sql-database" {
  depends_on    = [module.rg, module.sql-server]
  source        = "../../modules/azurerm_sql_db"
  sql_databases = var.sql_databases
}

module "key-vault" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "key-vault-secret" {
  depends_on        = [module.key-vault, module.rg]
  source            = "../../modules/azurerm_key_vault_secret"
  key_vault_secrets = var.key_vault_secrets
}
