project_id            = "mymigration-322809"
region                = "us-central1"
zone                 = "us-central1-a"
network_name         = "default"
subnet_name          = "default"
snapshot_name        = "ansiblegloden"

vms = [
  {
    name         = "test1"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test1-disk-1"
        size_gb = 10
      },
      {
        name    = "test1-disk-2"
        size_gb = 20
      }
    ]
  },
  {
    name         = "test2"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test2-disk-1"
        size_gb = 10
      },
      {
        name    = "test2-disk-2"
        size_gb = 20
      }
    ]
  },
  {
    name         = "test3"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test3-disk-1"
        size_gb = 10
      },
      {
        name    = "test3-disk-2"
        size_gb = 20
      }
    ]
  },
  {
    name         = "test4"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    disks = [
      {
        name    = "test4-disk-1"
        size_gb = 10
      },
      {
        name    = "test4-disk-2"
        size_gb = 20
      }
    ]
  }
]

tags = ["web", "production"]
//terraform