resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  # -------- Optional arguments --------
  tags        = lookup(each.value, "tags", null)
  dns_servers = lookup(each.value, "dns_servers", null)

  # -------- Block argument (ip_configuration) --------
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.ip_configuration_name
      subnet_id                     = data.azurerm_subnet.subnets[each.key].id
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation", "Dynamic")
      private_ip_address_version    = lookup(ip_configuration.value, "private_ip_address_version", null)
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
      primary                       = lookup(ip_configuration.value, "primary", null)
    }
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each                        = var.vms
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.vm-user[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.vm-password[each.key].value
  disable_password_authentication = false

  # --- Required Argument ---
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]


  # --- Optional Arguments ---
  tags                = lookup(each.value, "tags", null)
  availability_set_id = lookup(each.value, "availability_set_id", null)
  custom_data         = lookup(each.value, "custom_data", null)
  computer_name       = lookup(each.value, "computer_name", null)

  zone                         = lookup(each.value, "zone", null)
  proximity_placement_group_id = lookup(each.value, "proximity_placement_group_id", null)
  patch_assessment_mode        = lookup(each.value, "patch_assessment_mode", null)


  # --- OS Disk Configuration ---
  os_disk {
    caching              = lookup(each.value.os_disk, "caching", "ReadWrite")
    storage_account_type = lookup(each.value.os_disk, "storage_account_type", "Standard_LRS")
    disk_size_gb         = lookup(each.value.os_disk, "disk_size_gb", null)
    name                 = lookup(each.value.os_disk, "name", null)
  }

  # --- Source Image Reference ---
  source_image_reference {
    publisher = lookup(each.value.source_image_reference, "publisher", "Canonical")
    offer     = lookup(each.value.source_image_reference, "offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value.source_image_reference, "sku", "22_04-lts")
    version   = lookup(each.value.source_image_reference, "version", "latest")
  }
}

