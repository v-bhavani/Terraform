location = "westeurope"

# App1 VNet Configuration
app1_vnet_name     = "vnet-app1-dev"
app1_rg_name       = "asr1"
app1_address_space = ["10.1.0.0/16"]
app1_subnets = {
  "subnet1" = "10.1.1.0/24",
  "subnet2" = "10.1.2.0/24"
}
app1_tags = {
  Environment = "dev"
  Application = "app1"
}

# # App2 VNet Configuration
# app2_vnet_name     = "vnet-app2-dev"
# app2_rg_name       = "rg-app2-dev"
# app2_address_space = ["10.2.0.0/16"]
# app2_subnets = {
#   "subnet1" = "10.2.1.0/24"
#   "subnet2" = "10.2.2.0/24"
# }
# app2_tags = {
#   Environment = "dev"
#   Application = "app2"
# } 