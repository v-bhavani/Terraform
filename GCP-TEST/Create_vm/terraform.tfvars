project_id           = "mymigration-322809"
region               = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "ansiblegloden"
vms = [
  {
    name         = "regtest-1"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "vm1-disk-1"
        size_gb = 10
      },
       {
         name    = "vm1-disk-2"
         size_gb = 20
       }
    ]
  },
  {
    name         = "regtest-2"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "vm2-disk-1"
        size_gb = 10
      },
       {
         name    = "vm2-disk-2"
         size_gb = 30
       }
    ]
  }
]
tags = ["web", "production"]
//testingggg