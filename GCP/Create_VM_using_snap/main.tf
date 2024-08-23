provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket  = "terraformbcs" # Replace with your bucket name
    prefix  = "terraform/state/vm.tfstate"  # Path within the bucket for storing state files
  }
}

resource "google_compute_image" "snapshot_image" {
  name        = "${var.vm_name}-image"
  source_snapshot = "projects/${var.project_id}/global/snapshots/${var.snapshot_name}"
  family      = "default"
  project     = var.project_id
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = google_compute_image.snapshot_image.self_link
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      // Ephemeral public IP address
    }
  }

  //metadata = {
 //   ssh-keys = "${var.ssh_user}:${file(var.ssh_key_path)}"
 // }

  tags = var.tags

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

// output "instance_ip" {
//  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
// }
