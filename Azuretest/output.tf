output "virtual_machine_ids" {
  value = tomap({
    for k, vm in azurerm_linux_virtual_machine.main : k => vm.id
  })
}
