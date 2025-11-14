resource "azurerm_mssql_database" "sql_database" {
  for_each = var.sql_databases

  # ---------------- Required Arguments ----------------
  name      = each.value.name
  server_id = data.azurerm_mssql_server.sql_server[each.key].id

  # ---------------- Optional Arguments ----------------
  auto_pause_delay_in_minutes                                = lookup(each.value, "auto_pause_delay_in_minutes", null)
  create_mode                                                = lookup(each.value, "create_mode", null)
  creation_source_database_id                                = lookup(each.value, "creation_source_database_id", null)
  collation                                                  = lookup(each.value, "collation", null)
  elastic_pool_id                                            = lookup(each.value, "elastic_pool_id", null)
  enclave_type                                               = lookup(each.value, "enclave_type", null)
  geo_backup_enabled                                         = lookup(each.value, "geo_backup_enabled", null)
  maintenance_configuration_name                             = lookup(each.value, "maintenance_configuration_name", null)
  ledger_enabled                                             = lookup(each.value, "ledger_enabled", null)
  license_type                                               = lookup(each.value, "license_type", null)
  max_size_gb                                                = lookup(each.value, "max_size_gb", null)
  min_capacity                                               = lookup(each.value, "min_capacity", null)
  restore_point_in_time                                      = lookup(each.value, "restore_point_in_time", null)
  recover_database_id                                        = lookup(each.value, "recover_database_id", null)
  recovery_point_id                                          = lookup(each.value, "recovery_point_id", null)
  restore_dropped_database_id                                = lookup(each.value, "restore_dropped_database_id", null)
  restore_long_term_retention_backup_id                      = lookup(each.value, "restore_long_term_retention_backup_id", null)
  read_replica_count                                         = lookup(each.value, "read_replica_count", null)
  read_scale                                                 = lookup(each.value, "read_scale", null)
  sample_name                                                = lookup(each.value, "sample_name", null)
  sku_name                                                   = lookup(each.value, "sku_name", null)
  storage_account_type                                       = lookup(each.value, "storage_account_type", null)
  transparent_data_encryption_enabled                        = lookup(each.value, "transparent_data_encryption_enabled", true)
  transparent_data_encryption_key_vault_key_id               = lookup(each.value, "transparent_data_encryption_key_vault_key_id", null)
  transparent_data_encryption_key_automatic_rotation_enabled = lookup(each.value, "transparent_data_encryption_key_automatic_rotation_enabled", null)
  zone_redundant                                             = lookup(each.value, "zone_redundant", null)
  secondary_type                                             = lookup(each.value, "secondary_type", null)
  tags                                                       = lookup(each.value, "tags", {})

  # ---------------- Import Block (Optional) ----------------
  dynamic "import" {
    for_each = lookup(each.value, "import", null) == null ? [] : [each.value.import]
    content {
      storage_uri                  = try(import.value.storage_uri)
      storage_key                  = try(import.value.storage_key)
      storage_key_type             = try(import.value.storage_key_type)
      administrator_login          = try(import.value.administrator_login)
      administrator_login_password = try(import.value.administrator_login_password)
      authentication_type          = try(import.value.authentication_type)
      storage_account_id           = try(lookup(import.value, "storage_account_id", null))
    }
  }

  # ---------------- Threat Detection Policy (Optional) ----------------
  dynamic "threat_detection_policy" {
    for_each = lookup(each.value, "identity", null) == null ? [] : [each.value.identity]
    content {
      state                      = lookup(threat_detection_policy.value, "state", "Disabled")
      disabled_alerts            = lookup(threat_detection_policy.value, "disabled_alerts", null)
      email_account_admins       = lookup(threat_detection_policy.value, "email_account_admins", "Disabled")
      email_addresses            = lookup(threat_detection_policy.value, "email_addresses", null)
      retention_days             = lookup(threat_detection_policy.value, "retention_days", null)
      storage_account_access_key = lookup(threat_detection_policy.value, "storage_account_access_key", null)
      storage_endpoint           = lookup(threat_detection_policy.value, "storage_endpoint", null)
    }
  }

  # ---------------- Long Term Retention Policy (Optional) ----------------
  dynamic "long_term_retention_policy" {
    for_each = lookup(each.value, "long_term_retention_policy", null) == null ? [] : [each.value.long_term_retention_policy]
    content {
      weekly_retention  = lookup(long_term_retention_policy.value, "weekly_retention", null)
      monthly_retention = lookup(long_term_retention_policy.value, "monthly_retention", null)
      yearly_retention  = lookup(long_term_retention_policy.value, "yearly_retention", null)
      week_of_year      = lookup(long_term_retention_policy.value, "week_of_year", null)
    }
  }

  # ---------------- Short Term Retention Policy (Optional) ----------------
  dynamic "short_term_retention_policy" {
    for_each = lookup(each.value, "short_term_retention_policy", null) == [] ? [] : [each.value.short_term_retention_policy]
    content {
      retention_days           = short_term_retention_policy.value.retention_days
      backup_interval_in_hours = lookup(short_term_retention_policy.value, "backup_interval_in_hours", null)
    }
  }

  # ---------------- Identity Block (Optional) ----------------
#   dynamic "identity" {
#     for_each = lookup(each.value, "identity", null) == [] ? [] : [each.value.identity]
#     content {
#       type         = lookup(identity.value.type, null)
#       identity_ids = lookup(identity.value.identity_ids, null)
#     }
#   }

}
