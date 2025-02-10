output "vm_instance_details" {
  description = "Detailed information about the VM instance"
  value       = google_compute_instance.sap_vm.self_link
}

output "vm_name" {
  description = "Name of the created VM"
  value       = google_compute_instance.sap_vm.name
}

output "disk_details" {
  description = "Details of the VM's boot disk"
  value       = google_compute_instance.sap_vm.boot_disk[0]
}
