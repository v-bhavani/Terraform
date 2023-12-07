terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "0.6.0-beta1"
    }
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = "0.50.8"
    }
  }
}
 
provider "btp" {
  globalaccount = var.global_account
  username      = var.username
  password      = var.password
}

resource "btp_subaccount_role_collection_assignment" "Z_CUSTOM" {
  for_each             = toset("${var.Z_CUSTOM_users}")
  subaccount_id        = var.subaccount_id
  role_collection_name = var.Role13
  user_name            = each.value
  origin               = var.custom_idp
}

 resource "btp_subaccount_role_collection_assignment" "subaccount-service-admins" {
  for_each             = toset("${var.subaccount_service_admin_users}")
  subaccount_id        = var.subaccount_id
  role_collection_name = var.Role10
  user_name            = each.value
  origin               = var.custom_idp
}
