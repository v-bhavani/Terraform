output "managed_disk_id" {
  description = "The ID of the newly created managed disk."
  value       = azurerm_managed_disk.example.id
}
