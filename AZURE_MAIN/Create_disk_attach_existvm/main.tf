provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm"{
    resource_group_name = "cloud-demo"
    storage_account_name = "testcloud001423"
    container_name = "terraform"
    key = "diskcreateandattach.tfstate"
 }
}

# Data block to get the existing VM
data "azurerm_virtual_machine" "existing_vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
}

# Create a new managed disk
resource "azurerm_managed_disk" "example" {
  name                 = var.disk_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

# Attach the disk to the existing VM
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.example.id
  virtual_machine_id = data.azurerm_virtual_machine.existing_vm.id
  lun                = 0
  caching            = "ReadWrite"
}
