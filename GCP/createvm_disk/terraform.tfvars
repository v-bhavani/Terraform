project_id           = "$project_id"
region               = "$region"
zone                 = "$zone"
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
      },
      {
        name    = "$vm1disk3"
        size_gb = $vm1disk3size
      },
      {
        name    = "$vm1disk4"
        size_gb = $vm1disk4size
      },
      {
        name    = "$vm1disk5"
        size_gb = $vm1disk5size
      }
    ]
  }
]
tags = ["web", "production"]
