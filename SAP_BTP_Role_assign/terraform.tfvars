subaccount_id = "$var.subaccountid"
global_account = "$var.globalaccname"
username = "$var.username"
password = "$var.password"
Role10   = "$var.Role10"
Role13   = "$var.Role13"
Role13_users = [${var.subaccount_admins}] 
Role10_users = [${var.subaccount_service_admins}]
custom_idp   = "$var.customidp"
