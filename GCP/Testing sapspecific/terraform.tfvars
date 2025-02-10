project_id           = "sapspecific"
region               = "us-central1"
network_name         = "pay-pal"
subnet_name          = "pay-subnet"
service_account_email = "forsymphony@sapspecific.iam.gserviceaccount.com"
snapshot_name        = "pay-pal-golden-snap-v2"
tags                 = ["web", "production"]

# VM Configuration
vm_name      = "sap-vm-instance"
machine_type = "e2-standard-8"
zone         = "us-central1-a"

# Disk Configuration
disks = [
  {
    name    = "sap-vm-disk"
    size_gb = 10
    type    = "pd-standard"
  }
]
