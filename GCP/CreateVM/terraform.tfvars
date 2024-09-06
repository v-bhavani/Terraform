project_id           = "$project_id"
region               = "$region"
zone                 = "$zone"
network_name         = "$network"
subnet_name          = "$subnet"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "$snapshot"
vms = [
  {
    name         = "$vmname"
    machine_type = "$machinetype"
    zone         = "$zone"
  }
]
tags = ["web", "production"]
