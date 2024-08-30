provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket  = "terraformbcs"
    prefix  = "terraform/state/vm.tfstate"
  }
}

resource "google_compute_image" "snapshot_image" {
  name            = "${var.vm_name}-image"
  source_snapshot = "projects/${var.project_id}/global/snapshots/${var.snapshot_name}"
  family          = "default"
  project         = var.project_id
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image  = google_compute_image.snapshot_image.self_link
      size   = var.boot_disk_size_gb
      type   = var.disk_type
    }
  }

  dynamic "attached_disk" {
    for_each = var.data_disks
    content {
      source = google_compute_disk.data_disks[attached_disk.key].self_link
      device_name = attached_disk.value.device_name
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {}
  }

  tags = var.tags

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_disk" "data_disks" {
  count = length(var.data_disks)
  name  = var.data_disks[count.index].name
  size  = var.data_disks[count.index].size
  type  = var.data_disks[count.index].type
  zone  = var.zone
}