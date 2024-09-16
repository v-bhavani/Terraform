provider "azurerm" {
  features {}
}

resource "azurerm_managed_disk" "example" {
  name                 = var.diskname
  location             = var.location
  resource_group_name  = var.resourcegroup
  storage_account_type = var.st_acc_type
  create_option        = "Empty"
  disk_size_gb         = var.disktype

  tags = {
    Project  = var.project
    Duration = var.duration
    Owner    = var.owner
  }
}
