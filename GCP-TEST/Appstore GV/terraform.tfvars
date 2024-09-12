project_id           = "$project_id"
region               = "$region"
network_name         = "$network"
subnet_name          = "$subnet"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "$snapshot"
vms = [
  {
    name         = "$vm1-name"
    machine_type = "$machinetype"
    zone         = "$zone"
    disks = [
     {
        name    = "$vm1disk1"
        size_gb = $vm1disk1size
      },
      {
        name    = "$vm1disk2"
        size_gb = $vm1disk2size
      }
    ]
  },
  {
    name         = "$vm2-name"
    machine_type = "$machinetype"
    zone         = "$zone"
    disks = [
      {
        name    = "$vm2disk1"
        size_gb = $vm2disk1size
      },
      {
        name    = "$vm2disk2"
        size_gb = $vm2disk2size
      }
    ]
  }
]
tags = ["web", "production"]
