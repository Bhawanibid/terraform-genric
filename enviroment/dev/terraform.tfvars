rgs = {
  "rg1" = {
    name       = "rg-JapanEast-001"
    location   = "Japan East"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
  "rg2" = {
    name       = "rg-JapanEast-002"
    location   = "Japan East"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
}

stg = {
  "stg1" = {
    name                     = "devstgab10"
    resource_group_name      = "rg-JapanEast-001"
    location                 = "Japan East"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      env = "dev"
    }
  }
}

vnets = {
  "vnet1" = {
    vnet_name           = "sathi001"
    location            = "Japan East"
    resource_group_name = "rg-JapanEast-001"
    address_space       = ["10.0.0.0/16"]
    nsg_name            = "raw"
    security_rule = {
      rule1 = {
        security_rule_name         = "raw-007"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
    tags = {
      env = "dev"
    }
  }
  "vnet2" = {
    vnet_name           = "sathi002"
    location            = "Japan East"
    resource_group_name = "rg-JapanEast-002"
    address_space       = ["10.0.0.0/16"]
    nsg_name            = "raw-01"
    security_rule = {
      rule1 = {
        security_rule_name         = "raw-008"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
    tags = {
      env = "dev"
    }
  }
}


subnets = {
  subnet1 = {
    subnet_name          = "frontend-subnet"
    resource_group_name  = "rg-JapanEast-001"
    virtual_network_name = "sathi001"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet2 = {
    subnet_name          = "backend-subnet"
    resource_group_name  = "rg6-002"
    virtual_network_name = "sathi002"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

pips = {
  pip1 = {
    name                = "pip-ram-1"
    resource_group_name = "rg-JapanEast-001"
    location            = "Japan East"
    allocation_method   = "Static"

    # Optional
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10

    tags = {
      environment = "dev"
      project     = "terraform-lab"
    }
  }
  pip2 = {
    name                = "pip-ram-2"
    resource_group_name = "rg-JapanEast-002"
    location            = "Japan East"
    allocation_method   = "Static"

    # Optional
    sku                     = "Standard"
    sku_tier                = "Regional"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = 10

    tags = {
      environment = "dev"
      project     = "terraform-lab"
    }
  }
}




vms = {
  vm1 = {
    name                = "linux-vm-01"
    resource_group_name = "rg-JapanEast-001"
    location            = "Japan East"
    size                = "Standard_B2ms"
    secret_name         = "vm1-user"
    secret_password     = "vm1-password"
    key_vault_name      = "devkeyvault001"


    tags = {
      environment = "dev"
      owner       = "bhawani"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 64
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    nic_name = "connect-nic"

    pip_name             = "pip-ram-1"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "sathi001"
    ip_configuration = [{
      ip_configuration_name         = "ip-01"
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = ""
      public_ip_address_id          = ""
    }]
  }
  vm2 = {
    name                = "linux-vm-01"
    resource_group_name = "rg-JapanEast-002"
    location            = "Japan East"
    size                = "Standard_A4_v2"
    secret_name         = "vm1-user"
    secret_password     = "vm1-password"
    key_vault_name      = "devkeyvault001"

    tags = {
      environment = "dev"
      owner       = "bhawani"
    }
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 64
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    nic_name = "connect-nic"

    pip_name             = "pip-ram-2"
    subnet_name          = "backend-subnet"
    virtual_network_name = "sathi002"
    ip_configuration = [{
      ip_configuration_name         = "ip-02"
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = ""
      public_ip_address_id          = ""
    }]
  }
}


sql_servers = {
  sql1 = {
    name                = "mssqlserver-todo"
    resource_group_name = "rg-JapanEast-001"
    location            = "Japan East"
    version             = "12.0"
    key_vault_name      = "devkeyvault001"
    secret_name         = "sql-user"
    secret_password     = "sql-password"


    minimum_tls_version           = "1.2"
    public_network_access_enabled = true

    azuread_administrator = {
      login_username = "AdminBhawani"
      object_id      = " "
    }
    identity = {
      type = "SystemAssigned"
    }

    tags = {
      environment = "dev"
    }
  }
}


sql_databases = {
  db1 = {
    name                = "sql-todo-db"
    server_id           = " "
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    sku_name            = "S0"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    enclave_type        = "VBS"
    server_name         = "mssqlserver-todo"
    resource_group_name = "rg-JapanEast-001"


    tags = {
      environment = "dev"
    }

    short_term_retention_policy = {
      retention_days = 7
    }
  }
}


key_vaults = {
  kv1 = {
    name                = "devkeyvault001"
    location            = "Japan East"
    resource_group_name = "rg-JapanEast-001"

    sku_name = "standard"

    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false

    access_policy = [
      {
        key_permissions     = ["Create", "Get", "List", "Delete"]
        secret_permissions  = ["Get", "List", "Delete", "Set"]
        storage_permissions = ["Get", "List", "Delete"]
      }
    ]
  }
}


key_vault_secrets = {
  secret1 = {
    name                = "sql-user"
    value               = "adminBhawani"
    key_vault_name      = "devkeyvault001"
    resource_group_name = "rg-JapanEast-001"

    tags = {
      environment = "Sql_user"
    }
  }
  secret2 = {
    name                = "sql-password"
    value               = "Bhawani@123"
    key_vault_name      = "devkeyvault001"
    resource_group_name = "rg-JapanEast-001"

    tags = {
      environment = "Sql_pass"
    }
  }
  secret3 = {
    name                = "vm1-user"
    value               = "adminBhawani"
    key_vault_name      = "devkeyvault001"
    resource_group_name = "rg-JapanEast-001"

    tags = {
      environment = "Sql_pass"
    }
  }
  secret4 = {
    name                = "vm1-password"
    value               = "Bhawani@123"
    key_vault_name      = "devkeyvault001"
    resource_group_name = "rg-JapanEast-001"

    tags = {
      environment = "Sql_pass"
    }
  }
}

acr_configs = {
  acr1 = {
    name                = "acrprod001"
    resource_group_name = "rg-JapanEast-001"
    location            = "Japan East"
    sku                 = "Premium"
    admin_enabled       = false

    georeplications = [
      {
        location                = "central india"
        zone_redundancy_enabled = true
      },
      {
        location = "central india"
      }
    ]

    network_rule_set = {
      default_action = "Deny"
      ip_rule = [
        {
          action   = "Allow"
          ip_range = "10.10.0.0/16"
        }
      ]
    }
  }
}


aks_config = {
    aks1 = {
      name                = "prod-todo-aks"
      location            = "Japan East"
      resource_group_name = "rg-JapanEast-001"
      dns_prefix          = "prodaks"

      default_node_pool = {
        name       = "default"
        node_count = 2
        vm_size    = "Standard_D2_v2"
      }

      identity = {
        type = "SystemAssigned"
      }

      tags = {
        Environment = "Production"
        Owner       = "DevOpsTeam"
      }
    }
  }

