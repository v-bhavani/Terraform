subaccount_id = "$var.subaccountid"
global_account = "$var.globalaccname"
username = "$var.username"
password = "$var.password"
Role   = "$var.role"
users = [${var.subaccount_admins}]
identity_provider   = "$var.customidp"
