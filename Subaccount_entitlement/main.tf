terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "1.0.0-rc1"
    }
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = "0.51.3"
    }
  }
}

provider "btp" {
  globalaccount = var.globalaccount
  username      = var.username
  password      = var.password
}

resource "btp_directory" "parent" {
  name        = var.directory_name
  description = "This is the parent directory for ${var.directory_name}."
  labels      = {
    "architect"   = [var.architect]
    "costcenter"  = [var.costcenter]
    "owner"       = [var.owner]
    "team"        = [var.team]
  }
}

resource "btp_subaccount" "subaccount" {
  name      = var.subaccount_name
  subdomain = replace(lower(replace(var.subaccount_name, "_", "-")), " ", "")
  region    = var.region
}
resource "btp_subaccount_entitlement" "alert_notification_service" {
  subaccount_id = btp_subaccount.subaccount.id
  service_name  = var.entitlement_name
  plan_name     = var.plan
}
