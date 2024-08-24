
project_id         = "mymigration-322809"
region             = "us-central1"
zone               = "us-central1-a"
vm_name            = "bcsvmterraform"
machine_type       = "e2-standard-8"  # or any other machine type
snapshot_name      = "goldensnapterraform"
disk_size_gb       = 20
disk_type          = "pd-standard"  # or "pd-ssd"
network_name       = "default"  # or your network name
subnet_name        = "default"  # or your subnet name
//ssh_user           = "your-username"
//ssh_key_path       = "~/.ssh/id_rsa.pub"  # path to your SSH public key
tags               = ["web", "production"]  # example tags
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"


