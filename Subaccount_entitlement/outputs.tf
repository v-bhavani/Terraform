output "parent_directory_id" {
  value = btp_directory.parent.id
}

output "subaccount_ids" {
  value = btp_subaccount.subaccount[*].id
}

output "entitlement_id" {
  value = btp_subaccount_entitlement.alert_notification_service.id
}

output "entitlement_key" {
  value = btp_subaccount_entitlement.alert_notification_service.key
}

output "entitlement_instance_id" {
  value = btp_subaccount_entitlement.alert_notification_service.instance_id
}
