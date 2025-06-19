output "app1_vnet_status" {
  value = module.app1_vnet.creation_status
}

output "app1_vnet_details" {
  value = {
    id            = module.app1_vnet.vnet_id
    name          = module.app1_vnet.vnet_name
    address_space = module.app1_vnet.address_space
    subnet_ids    = module.app1_vnet.subnet_ids
  }
}

# output "app2_vnet_status" {
#   value = module.app2_vnet.creation_status
# }

# output "app2_vnet_details" {
#   value = {
#     id            = module.app2_vnet.vnet_id
#     name          = module.app2_vnet.vnet_name
#     address_space = module.app2_vnet.address_space
#     subnet_ids    = module.app2_vnet.subnet_ids
#   }
# }