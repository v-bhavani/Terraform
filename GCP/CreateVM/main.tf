# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Configure the backend
terraform {
  backend "gcs" {
    bucket = "terraformbackline"  # Replace with your bucket name
    prefix = "state/blackline.tfstate"
  }
}

# Create images from snapshots for each VM
resource "google_compute_image" "snapshot_image" {
  for_each        = { for vm in var.vms : vm.name => vm }
  name            = "${each.value.name}-image"
  source_snapshot = "projects/${var.project_id}/global/snapshots/${var.snapshot_name}"
  family          = "default"
  project         = var.project_id
}

# Create VM instances with root disk from snapshots
resource "google_compute_instance" "vm_instance" {
  for_each     = { for vm in var.vms : vm.name => vm }
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = google_compute_image.snapshot_image[each.key].self_link
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      // Ephemeral public IP address
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = var.tags
}
