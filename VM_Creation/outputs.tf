output "vm_instance_details" {
  value = {
    for vm in google_compute_instance.vm_instance : vm.name => {
      instance_id = vm.id
      private_ip  = vm.network_interface[0].network_ip
      public_ip   = vm.network_interface[0].access_config[0].nat_ip
      disks = [
        for disk in google_compute_disk.data_disk : {
          name = disk.name
          size = disk.size
        } if startswith(disk.name, vm.name)
      ]
    }
  }
}
