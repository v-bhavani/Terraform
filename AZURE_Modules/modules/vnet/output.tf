output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.this.name
}

output "address_space" {
  description = "Virtual Network address space"
  value       = azurerm_virtual_network.this.address_space
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "creation_status" {
  description = "Creation status message"
  value       = "VNet ${azurerm_virtual_network.this.name} with ${length(var.subnets)} subnets created successfully in RG ${var.resource_group_name}"
}