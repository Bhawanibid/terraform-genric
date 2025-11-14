
variable "vms" {
  description = "Map of Linux Virtual Machines configuration"
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    size                  = string
    secret_name           = string
    secret_password       = string
    network_interface_ids = optional(list(string))
    key_vault_name        = string

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


