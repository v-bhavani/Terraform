provider "google" {
project = var.project_id
region = var.region
zone = var.zone
impersonate_service_account = var.tf_service_account
}

resource "google_compute_disk" "my_disk" {
  name  = var.disk_name
  type  = var.disk_type
  size  = var.disk_size 
  zone  = var.zone 
}