project_id           = "mymigration-322809"
region               = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "ansiblegloden"

vms = [
  {
    name         = "vm1-sl"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "vm1-usr-sap"
        size_gb = 32
      },
      {
        name    = "vm1-shared"
        size_gb = 16
      },
      {
        name    = "vm1-data"
        size_gb = 64
      },
      {
        name    = "vm1-log"
        size_gb = 16
      },
      {
        name    = "vm1-softdump"
        size_gb = 64
      }
    ]
  }
]
tags = ["web", "production"]
