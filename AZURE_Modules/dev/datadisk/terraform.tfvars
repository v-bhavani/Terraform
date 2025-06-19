disk_name = "dev-datadisk"
resource_group_name = "dev-rg"
location = "eastus"
disk_size_gb = 20
vm_id = "/subscriptions/.../resourceGroups/dev-rg/providers/Microsoft.Compute/virtualMachines/dev-vm"
tags = {
  environment = "dev"
  purpose     = "data-storage"
}