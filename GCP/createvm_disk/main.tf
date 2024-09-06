# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Configure the backend
terraform {
  backend "gcs" {
    bucket = "terraformbcs"  # Replace with your bucket name
    prefix = "terraform/state/commit.tfstate"
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

# Create disks for VMs
resource "google_compute_disk" "data_disk" {
  for_each = {
    for disk in flatten([
      for vm in var.vms : [
        for i, disk in vm.disks : {
          key     = "${vm.name}-disk-${i + 1}"  # Unique key for each disk
          vm_name = vm.name
          size_gb = disk.size_gb
          zone    = vm.zone
        }
      ]
    ]) : disk.key => disk
  }

  name  = each.key
  size  = each.value.size_gb
  zone  = each.value.zone
  type  = "pd-standard"
}

# Create VM instances and attach disks
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

  # Attach data disks to the VM
  dynamic "attached_disk" {
    for_each = {
      for key, disk in google_compute_disk.data_disk :
      key => disk
      if startswith(key, each.key)
    }
    content {
      source = attached_disk.value.self_link
      mode   = "READ_WRITE"
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = var.tags
}

