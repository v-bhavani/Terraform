provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "terraformbcs"  
    prefix = "terraform/state/vm-test.tfstate"
  }
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
      image = "debian-cloud/debian-11" # Using Debian for cost-effectiveness
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
    access_config {}
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


  tags = var.tags

  depends_on = [google_compute_disk.data_disk]
}
