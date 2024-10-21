project_id           = "innovation-cs-11560"
region               = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
service_account_email = "symphony-cmd@innovation-cs-11560.iam.gserviceaccount.com"
snapshot_name        = "sles-15-sp4-sap-snapshot-1"
vms = [
  {
    name         = "blksapdrpoc"
    machine_type = "n2-standard-64"
    zone         = "us-central1-a"
    disks = []
  }
]
tags = ["web", "production"]
