output "rg_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "rg_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "rg_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.this.location
}

output "creation_status" {
  description = "Resource group creation status"
  value       = "Resource group ${azurerm_resource_group.this.name} created successfully in ${azurerm_resource_group.this.location}"
}