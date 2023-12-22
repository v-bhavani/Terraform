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

resource "btp_subaccount" "subaccount" {
  name      = var.subaccount_name
  subdomain = replace(lower(replace(var.subaccount_name, "_", "-")), " ", "")
  region    = var.region
  parent_id = var.parent_directory
}
resource "btp_subaccount_entitlement" "alert_notification_service" {
  subaccount_id = btp_subaccount.subaccount.id
  service_name  = var.entitlement_name
  plan_name     = var.plan
}
