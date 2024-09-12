# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Configure the backend
terraform {
  backend "gcs" {
    bucket = "terraformbcs"  # Replace with your bucket name
    prefix = "terraform/state/appstore1.tfstate"
  }
}

resource "google_compute_image" "snapshot_image" {
  for_each       = { for vm in var.vms : vm.name => vm }
  name           = "${each.value.name}-image"
  source_snapshot = "projects/${var.project_id}/global/snapshots/${var.snapshot_name}"
  family         = "default"
  project        = var.project_id
}

resource "google_compute_disk" "data_disk" {
  for_each = {
    for disk in flatten([
      for vm in var.vms : [
        for disk in vm.disks : {
          key      = "${vm.name}-${disk.name}"
          size_gb  = disk.size_gb
          zone     = vm.zone
        }
      ]
    ]) : disk.key => disk
  }

  name  = each.key
  size  = each.value.size_gb
  zone  = each.value.zone
  type  = "pd-standard"
}

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

  dynamic "attached_disk" {
    for_each = [
      for disk in google_compute_disk.data_disk : disk if startswith(disk.name, each.value.name)
    ]
    content {
      source      = attached_disk.value.self_link
      device_name = attached_disk.value.name
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = var.tags

  depends_on = [google_compute_disk.data_disk]  # Ensure disks are created first
}
