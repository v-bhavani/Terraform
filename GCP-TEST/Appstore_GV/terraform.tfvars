project_id           = "mymigration-322809"
region               = "us-central1"
zone                 ="us-central1-a"
network_name         = "default"
subnet_name          = "default"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "ansiblegloden"
vms = [
  {
    name         = "vm1-appstore"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
     {
        name    = "test1disk1"
        size_gb = 10
      },
      {
        name    = "test1disk2"
        size_gb = 16
      }
    ]
  },
  {
    name         = "vm2-appstore"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test2disk1"
        size_gb = 16
      },
      {
        name    = "test2disk2"
        size_gb = 20
      }
    ]
  },
  {
    name         = "vm3-appstore"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test3disk1"
        size_gb = 10
      },
      {
        name    = "test3disk2"
        size_gb = 15
      }
    ]
  }

]
tags = ["web", "production"]