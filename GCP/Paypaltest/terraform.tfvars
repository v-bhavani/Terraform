
project_id           = "mymigration-322809"
region               = "us-central1"
network_name         = "test-paypal"
subnet_name          = "paypal-test"
service_account_email = "serviceacforiam@mymigration-322809.iam.gserviceaccount.com"
snapshot_name        = "ansiblegloden"
tags = ["web", "production"]
vms = [
  {
    name         = "dahpaydb"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    private_ip   = "10.0.0.13"
    disks = [
      {
        name    = "dev-s4hana-dahpaydb-backup"
        size_gb = 100
        type    = "pd-standard"
      },
      {
        name    = "dev-s4hana-dahpaydb-shared"
        size_gb = 64
        type    = "pd-standard"
      },
      {
        name    = "dev-s4hana-dahpaydb-data"
        size_gb = 64
        type    = "pd-standard"
      },
      {
        name    = "dev-s4hana-dahpaydb-log"
        size_gb = 50
        type    = "pd-standard"
      }
    ]
  },
  {
    name         = "dahpay01db"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    private_ip   = "10.0.0.14"
    disks = []
  },
  {
    name         = "dahpay02db"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    private_ip   = "10.0.0.15"
    disks = []
  },
  {
    name         = "dahpaypapp"
    machine_type = "e2-standard-8"
    zone         = "us-central1-a"
    private_ip   = "10.0.0.16"
    disks = [
      {
        name    = "dev-s4hana-dahpaypapp-usrsap"
        size_gb = 20
        type    = "pd-standard"
      },
      {
        name    = "dev-s4hana-dahpaypapp-sapmnt"
        size_gb = 15
        type    = "pd-standard"
      },
      {
        name    = "dev-s4hana-dahpaypapp-softdump"
        size_gb = 64
        type    = "pd-standard"
      }
    ]
  }
]
