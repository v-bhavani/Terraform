output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "vm_name" {
  description = "The name of the VM instance."
  value       = google_compute_instance.vm_instance.name
}

output "private_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "instance_id" {
  value = google_compute_instance.vm_instance.id
}
