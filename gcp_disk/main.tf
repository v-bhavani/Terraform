provider "google" {
  region      = var.region
  project     = var.project_id
  credentials = file(var.credentials_file_path)
  zone        = var.zone
}

resource "google_compute_disk" "my_disk" {
  name  = var.disk_name
  type  = var.disk_type
  size  = var.disk_size 
  zone  = var.zone 
}
