output "virtual_machine_id" {
  value = tomap({
    for k, vm in azurerm_linux_virtual_machine.main : k => vm.id
  })
}
