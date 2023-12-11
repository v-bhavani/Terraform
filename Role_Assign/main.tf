terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "1.0.0-rc1"
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

resource "btp_subaccount_role_collection_assignment" "role-assign" {
  for_each             = toset("${var.users}")
  subaccount_id        = var.subaccount_id
  role_collection_name = var.role
  user_name            = each.value
  origin               = var.identity_provider
}

