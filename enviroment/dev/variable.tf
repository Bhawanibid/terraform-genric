variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "stg" {
  type = map(object({
    # --- Required Fields ---
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # --- Optional Fields ---
    tags                            = optional(map(string), {})
    account_kind                    = optional(string, "StorageV2")
    access_tier                     = optional(string, "Hot")
    min_tls_version                 = optional(string, "TLS1_2")
    allow_nested_items_to_be_public = optional(bool, false)
    shared_access_key_enabled       = optional(bool, true)
    default_to_oauth_authentication = optional(bool, false)
    is_hns_enabled                  = optional(bool, false)
    nfsv3_enabled                   = optional(bool, false)
    large_file_share_enabled        = optional(bool, false)
    public_network_access_enabled   = optional(bool, true)

  }))
}

variable "vnets" {
  type = map(object({
    nsg_name = string

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

variable "subnets" {
  description = "Map of subnet configurations."
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string

    # ---------- Optional Arguments ----------
    address_prefixes                              = optional(list(string))
    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    tags                                          = optional(map(string))

    # ---------- Optional ip_address_pool Block ----------
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))

    # ---------- Optional delegation Block ----------
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    }))
  }))
}

variable "pips" {
  description = "Map of Public IP configurations."
  type = map(object({
    # ---------- Required ----------
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    # ---------- Optional ----------
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
  }))
}



variable "vms" {
  description = "Map of Linux Virtual Machines configuration"
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    size                  = string
    secret_name           = string
    secret_password       = string
    key_vault_name        = string
    
    network_interface_ids = optional(list(string))

    # Optional arguments
    tags                            = optional(map(string))
    availability_set_id             = optional(string)
    custom_data                     = optional(string)
    computer_name                   = optional(string)
    disable_password_authentication = optional(bool, true)
    zone                            = optional(string)
    proximity_placement_group_id    = optional(string)
    patch_assessment_mode           = optional(string)



    # OS Disk configuration
    os_disk = object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Standard_LRS")
      disk_size_gb         = optional(number)
      name                 = optional(string)
    })

    # Source image reference block
    source_image_reference = object({
      publisher = optional(string, "Canonical")
      offer     = optional(string, "0001-com-ubuntu-server-jammy")
      sku       = optional(string, "22_04-lts")
      version   = optional(string, "latest")
    })
    # nic details
    nic_name = string


    subnet_name          = string
    pip_name             = string
    virtual_network_name = string


    # Optional fields

    dns_servers = optional(list(string))

    # Block for ip_configuration
    ip_configuration = list(object({
      ip_configuration_name         = string
      subnet_id                     = optional(string)
      private_ip_address_allocation = optional(string)
      private_ip_address_version    = optional(string)
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool)
    }))

  }))
}


variable "sql_servers" {
  description = "Map of SQL Servers to be created"
  type = map(object({
    # ----- Required -----
    name                = string
    resource_group_name = string
    location            = string
    version             = string
    key_vault_name      = string
    secret_name         = string
    secret_password     = string

    # ----- Optional -----
    # administrator_login                          = optional(string)
    # administrator_login_password                 = optional(string)
    administrator_login_password_wo              = optional(string)
    administrator_login_password_wo_version      = optional(number)
    connection_policy                            = optional(string)
    express_vulnerability_assessment_enabled     = optional(bool)
    transparent_data_encryption_key_vault_key_id = optional(string)
    minimum_tls_version                          = optional(string)
    public_network_access_enabled                = optional(bool)
    outbound_network_restriction_enabled         = optional(bool)
    primary_user_assigned_identity_id            = optional(string)
    tags                                         = optional(map(string))

    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
  }))
}

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

variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type = map(object({
    # ---------- Required ----------
    name                = string
    location            = string
    resource_group_name = string
    # tenant_id           = string
    sku_name            = string

    # ---------- Optional ----------
    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    rbac_authorization_enabled      = optional(bool)
    purge_protection_enabled        = optional(bool)
    public_network_access_enabled   = optional(bool)
    soft_delete_retention_days      = optional(number)
    tags                            = optional(map(string))

    # ---------- Optional Blocks ----------
    access_policy = optional(list(object({
    #   tenant_id               = optional(string)
    #   object_id               = optional(string)
      application_id          = optional(string)
      certificate_permissions = optional(list(string))
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      storage_permissions     = optional(list(string))
    })))

    network_acls = optional(list(object({
      bypass                     = optional(string)
      default_action             = optional(string)
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    })))
  }))
}

variable "key_vault_secrets" {
  description = "Map of Key Vault Secrets configuration."
  type = map(object({
    # ---------- Required ----------
    name                = string
    key_vault_name      = string
    resource_group_name = string

    # ---------- Optional ----------
    value            = optional(string)
    value_wo         = optional(string)
    value_wo_version = optional(number)
    content_type     = optional(string)
    not_before_date  = optional(string)
    expiration_date  = optional(string)
    tags             = optional(map(string))
  }))
}

