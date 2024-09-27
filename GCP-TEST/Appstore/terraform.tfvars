network_name = "default"
  project_id = "mymigration-322809"
  region = "us-central1"
  service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
  snapshot_name = "ansiblegloden"
  subnet_name = "default"
  tags = [
    "web",
    "production","testinggcp"
  ]
  vms = [
    {
      disks = [
        {
          name = "vm1-disk-1"
          size_gb = 10
        },
        {
          name = "vm1-disk-2"
          size_gb = 20
        }
      ]
      machine_type = "e2-standard-8"
      name = "vm1-appstore"
      zone = "us-central1-a"
    },
    {
      name = "vm-2-appstore"
      machine_type = "e2-standard-8"
      zone = "us-central1-a"
      disks = [
        {
          name = "vm2-disk-1"
          size_gb = 10
        },
        {
          name = "vm2-disk-2"
          size_gb = 30
        }
      ]
    }
  ]
  zone = "us-central1-a"