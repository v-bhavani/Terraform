project_id           = "sapspecific"
region               = "us-east1"
zone                 = "us-east1-c"
network_name         = "default"
subnet_name          = "default"
service_account_email = "1088675481439-compute@developer.gserviceaccount.com"
snapshot_name        = "susesdisk1"
vms = [
  {
    name         = "blksapdrpoc"
    machine_type = "e2-standard-32"
    zone         = "us-east1-c"
    disks = []
  }
]
tags = ["web", "production"]
//test