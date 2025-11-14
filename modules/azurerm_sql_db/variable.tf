variable "sql_databases" {
  description = "Map of SQL Databases to be created"
  type = map(object({
    # ----- Required -----
    name      = string
    server_id = string

    # -----data block sql_server required fields -----
    server_name         = string
    resource_group_name = string

    # ----- Optional -----
    auto_pause_delay_in_minutes                                = optional(number)
    create_mode                                                = optional(string)
    creation_source_database_id                                = optional(string)
    collation                                                  = optional(string)
    elastic_pool_id                                            = optional(string)
    enclave_type                                               = optional(string)
    geo_backup_enabled                                         = optional(bool)
    maintenance_configuration_name                             = optional(string)
    ledger_enabled                                             = optional(bool)
    license_type                                               = optional(string)
    max_size_gb                                                = optional(number)
    min_capacity                                               = optional(number)
    restore_point_in_time                                      = optional(string)
    recover_database_id                                        = optional(string)
    recovery_point_id                                          = optional(string)
    restore_dropped_database_id                                = optional(string)
    restore_long_term_retention_backup_id                      = optional(string)
    read_replica_count                                         = optional(number)
    read_scale                                                 = optional(bool)
    sample_name                                                = optional(string)
    sku_name                                                   = optional(string)
    storage_account_type                                       = optional(string)
    transparent_data_encryption_enabled                        = optional(bool)
    transparent_data_encryption_key_vault_key_id               = optional(string)
    transparent_data_encryption_key_automatic_rotation_enabled = optional(bool)
    zone_redundant                                             = optional(bool)
    secondary_type                                             = optional(string)
    tags                                                       = optional(map(string))
    prevent_destroy                                            = optional(bool)

    import = optional(object({
      storage_uri                  = optional(string)
      storage_key                  = optional(string)
      storage_key_type             = optional(string)
      administrator_login          = optional(string)
      administrator_login_password = optional(string)
      authentication_type          = optional(string)
      storage_account_id           = optional(string)
    }))

    threat_detection_policy = optional(object({
      state                      = optional(string)
      disabled_alerts            = optional(list(string))
      email_account_admins       = optional(string)
      email_addresses            = optional(list(string))
      retention_days             = optional(number)
      storage_account_access_key = optional(string)
      storage_endpoint           = optional(string)
    }))

    long_term_retention_policy = optional(object({
      weekly_retention  = optional(string)
      monthly_retention = optional(string)
      yearly_retention  = optional(string)
      week_of_year      = optional(number)
    }))

    short_term_retention_policy = optional(object({
      retention_days           = number
      backup_interval_in_hours = optional(number)
    }))

    # identity = optional(object({
    #   type         = string
    #   identity_ids = list(string)
    # }))
  }))

}
