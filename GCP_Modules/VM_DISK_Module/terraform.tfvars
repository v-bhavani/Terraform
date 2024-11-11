project_id           = "sapspecific"
region               = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
service_account_email = "test-auth-symphony@sapspecific.iam.gserviceaccount.com"
snapshot_name        = "susesdisk1"
vms = [
  {
    name         = "blksapdrpoc"
    machine_type = "e2-standard-32"
    zone         = "us-central1-a"
    disks = []
  }
]
tags = ["web", "production"]