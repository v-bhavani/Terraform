project_id         = "mymigration-322809"
region             = "us-central1"
zone               = "us-central1-a"
network_name       = "default"  # or your network name
subnet_name        = "default"  # or your subnet name
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name      = "ansiblegloden"

vms = [
  {
    name         = "vm1"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        size_gb = 10
      },
      {
        size_gb = 20
      }
    ]
  },
  {
    name         = "vm2"
    machine_type = "e2-standard-16"
    zone         = "us-central1-a"
    disks = [
      {
        size_gb = 15
      },
      {
        size_gb = 25
      },
      {
        size_gb = 30
      }
    ]
  },
    {
    name         = "vm3"
    machine_type = "e2-standard-16"
    zone         = "us-central1-a"
    disks = [
      {
        size_gb = 20
      },
      {
        size_gb = 25
      },
      {
        size_gb = 30
      }
    ]
  }
]
tags = ["web", "production"]
