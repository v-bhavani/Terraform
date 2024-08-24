output "disk_name" {
  value = google_compute_disk.data_disk.name
}

output "disk_device_name" {
  value = google_compute_attached_disk.disk_attachment.device_name
}