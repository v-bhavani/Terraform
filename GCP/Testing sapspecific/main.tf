provider "google" {
  project = var.project_id
  region  = var.region
  impersonate_service_account = "test-auth-symphony@sapspecific.iam.gserviceaccount.com"
}

terraform {
  backend "gcs" {
    bucket = "testing-paypal"
    prefix = "testing/dev"
    impersonate_service_account = "test-auth-symphony@sapspecific.iam.gserviceaccount.com"
  }
}

resource "google_compute_instance" "sap_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.snapshot_name
      size  = var.disks[0].size_gb
      type  = var.disks[0].type
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  tags = var.tags
}
