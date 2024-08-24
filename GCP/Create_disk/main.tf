provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

terraform {
  backend "gcs" {
    bucket  = "terraformbcs" # Replace with your bucket name
    prefix  = "terraform/state/disk.tfstate"  # Path within the bucket for storing state files
  //  key     = "disk.tfstate" # Custom name for the state file
  }
}

resource "google_compute_disk" "data_disk" {
  name  = var.disk_name
  type  = var.disk_type    // "pd-standard" 
  zone  = var.zone
  size  = var.disk_size

  labels = {
    environment = var.environment
  }
}

resource "google_compute_attached_disk" "disk_attachment" {
  disk       = google_compute_disk.data_disk.id
  instance   = var.vm_name
  device_name = var.disk_name
  zone       = var.zone
}
