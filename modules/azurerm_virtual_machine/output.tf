output "vm_ids" {
  description = "IDs of all created Linux Virtual Machines"
  value = { for k, v in azurerm_linux_virtual_machine.virtual_machine : k => v.id }
}