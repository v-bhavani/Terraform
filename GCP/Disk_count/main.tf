provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket  = "terraformbcs" # Replace with your bucket name
    prefix  = "terraform/state/disk_count.tfstate"  # Path within the bucket for storing state files
  }
}

resource "google_compute_disk" "data_disk" {
  count = var.disk_count

  name  = "${var.disk_name}-${count.index}"
  type  = var.disk_type
  zone  = var.zone
  size  = var.disk_sizes[count.index]
  labels = {
    environment = var.environment
  }
}

resource "google_compute_attached_disk" "disk_attachment" {
  count = var.disk_count

  disk       = google_compute_disk.data_disk[count.index].id
  instance   = var.vm_name
  zone       = var.zone
}
