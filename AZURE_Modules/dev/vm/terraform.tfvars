vm_name = "dev-vm"
resource_group_name = "dev-rg"
location = "eastus"
admin_username = "adminuser"
admin_password = null
ssh_keys = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
]
subnet_id = "/subscriptions/.../resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/subnet1"
create_public_ip = true
tags = {
  environment = "dev"
  role        = "webserver"
}