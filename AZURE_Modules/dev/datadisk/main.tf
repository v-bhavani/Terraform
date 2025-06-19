module "datadisk" {
  source = "../modules/datadisk"

  disk_name           = var.disk_name
  resource_group_name = var.resource_group_name
  location            = var.location
  storage_account_type = var.storage_account_type
  disk_size_gb        = var.disk_size_gb
  vm_id               = var.vm_id
  lun                 = var.lun
  caching             = var.caching
  tags                = var.tags
}