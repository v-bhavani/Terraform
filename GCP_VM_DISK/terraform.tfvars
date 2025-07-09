project_id           = "sapspecific"
region               = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
snapshot_name        = "susesdisk1"

vms = [
  {
    name         = "vm1"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "vm1-disk-1"
        size_gb = 10
      },
      {
        name    = "vm1-disk-2"
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
        name    = "vm2-disk-1"
        size_gb = 15
      },
      {
        name    = "vm2-disk-2"
        size_gb = 25
      },
      {
        name    = "vm2-disk-3"
        size_gb = 30
      }
    ]
  }
]

tags = ["web", "production"]   #Network Tags
//test
