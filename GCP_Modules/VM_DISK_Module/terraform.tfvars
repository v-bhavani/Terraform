project_id           = "mymigration-322809"
region                = "us-central1"
state_bucket          = "terraformbcs"
state_prefix          = "terraform/state/vm1.tfstate"
snapshot_name         = "ansiblegloden"
network_name         = "default"
subnet_name          = "default"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
tags =                   ["web", "production"]

vms = [
  {
    name         = "vm1-symtest"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "vm-1-data-1"
        size_gb = 10
      },
     {
        name    = "vm-1-data-2"
        size_gb = 10
      }
    ]
  }
]

#thankyou
