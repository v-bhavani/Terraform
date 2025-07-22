output "disk_id" {
  value = azurerm_managed_disk.example.id
}
output "disk_name" {
  value = azurerm_managed_disk.example.name
}
output "disk_location" {
  value = azurerm_managed_disk.example.location
}
output "disk_resource_group" {
  value = azurerm_managed_disk.example.resource_group_name
}
output "disk_storage_account_type" {
  value = azurerm_managed_disk.example.storage_account_type
}
output "disk_create_option" {
  value = azurerm_managed_disk.example.create_option
}
output "disk_size_gb" {
  value = azurerm_managed_disk.example.disk_size_gb
}
output "disk_tags" {
  value = azurerm_managed_disk.example.tags
}
