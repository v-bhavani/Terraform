module "vm" {
  source = "../modules/vm"

  vm_name           = var.vm_name
  resource_group_name = var.resource_group_name
  location          = var.location
  vm_size           = var.vm_size
  admin_username    = var.admin_username
  admin_password    = var.admin_password
  ssh_keys          = var.ssh_keys
  subnet_id         = var.subnet_id
  create_public_ip  = var.create_public_ip
  tags              = var.tags
}