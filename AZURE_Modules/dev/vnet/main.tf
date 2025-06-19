module "app1_vnet" {
  source              = "../../modules/vnet"
  vnet_name           = var.app1_vnet_name
  resource_group_name = var.app1_rg_name
  location            = var.location
  address_space       = var.app1_address_space
  subnets             = var.app1_subnets
  tags                = var.app1_tags
}

# module "app2_vnet" {
#   source              = "../../modules/vnet"
#   vnet_name           = var.app2_vnet_name
#   resource_group_name = var.app2_rg_name
#   location            = var.location
#   address_space       = var.app2_address_space
#   subnets             = var.app2_subnets
#   tags                = var.app2_tags
# }