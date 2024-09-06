project_id           = "$project"
region               = "$region"
zone                 = "$zone1"
network_name         = "$network"
subnet_name          = "$subnet"
service_account_email = "$service"
snapshot_name        = "$snapshot"
vms = [
  {
    name         = "$vmname"
    machine_type = "$machinetype"
    zone         = "$zone1"
    disks = []
  }
]
tags = ["web", "production"]
