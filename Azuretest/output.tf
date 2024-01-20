output "public_ip_addresses" {
  description = "Public IP addresses assigned to the VMs"
  value       = azurerm_public_ip.vm_public_ip[*].ip_address
}

output "vm_network_interface_ids" {
  description = "Network Interface IDs of the created VMs"
  value       = azurerm_network_interface.vm_nic[*].id
}

output "vm_ids" {
  description = "IDs of the created VMs"
  value       = azurerm_linux_virtual_machine.main[*].id
}

