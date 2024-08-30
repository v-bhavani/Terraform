project_id           = "mymigration-322809"
region               = "us-central1"
zone                 = "us-central1-a"
vm_name              = "sample-vm2"
machine_type         = "e2-standard-16"
snapshot_name        = "ansiblegloden"
boot_disk_size_gb    = 30
disk_type            = "pd-standard"
network_name         = "default"
subnet_name          = "default"
tags                 = ["web", "production"]
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"

data_disks = [
  {
    name        = "data-disk1-vm2"
    size        = 10
    device_name = "disk1"
    type        = "pd-ssd"
  },
  {
    name        = "data-disk2-vm2"
    size        = 20
    device_name = "disk2"
    type        = "pd-standard"
  }
]
