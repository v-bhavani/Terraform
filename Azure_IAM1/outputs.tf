output "assigned_principal_ids" {
  description = "The IDs of the principals assigned the specified role"
  value       = azurerm_role_assignment.role_assignment.principal_id
}
