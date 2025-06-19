output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "private_ip_address" {
  description = "The private IP address of the virtual machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the virtual machine (if created)"
  value       = var.create_public_ip ? azurerm_public_ip.pip[0].ip_address : null
}

output "admin_username" {
  description = "The admin username of the virtual machine"
  value       = var.admin_username
  sensitive   = true
}