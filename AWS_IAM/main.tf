provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_iam_user" "example" {
  name = var.username
}

resource "aws_iam_user_login_profile" "example_user_password" {
  user                    = aws_iam_user.example.name
  password_length         = 16 # Change to your desired password length
  password_reset_required = true
  count                   = var.enable_console_access ? 1 : 0
}

# Generate a temporary password
resource "random_password" "temp_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Your IAM user policy attachments can be added here

resource "aws_iam_user_policy_attachment" "example_user_policies" {
  count      = length(var.policy_arn)
  user       = aws_iam_user.example.name
  policy_arn = var.policy_arn[count.index]
}

# Your IAM user group memberships can be added here

resource "aws_iam_user_group_membership" "example_user_groups" {
  count  = length(var.group_names)
  user   = aws_iam_user.example.name
  groups = [var.group_names[count.index]]
}

resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example.name
}

# Output the access key and secret key as a CSV file
resource "local_file" "access_key_csv" {
  filename = "${var.username}_access_keys.csv"
  content = <<-EOT
    Access Key,Secret Key
    ${aws_iam_access_key.example_access_key.id},${aws_iam_access_key.example_access_key.secret}
  EOT
}

# Output the user creation information as a CSV file
resource "local_file" "user_creation_csv" {
  filename = "${var.username}_user_creation_info.csv"
  content = <<-EOT
    IAM Username,Password,Console Login URL
    ${aws_iam_user.example.name},${random_password.temp_password.result},https://${var.account_id}.signin.aws.amazon.com/console
  EOT
}

# Print the URL to download the access key CSV file
output "access_key_csv_download_url" {
  value = local_file.access_key_csv.filename
}

# Print the URL to download the user creation CSV file
output "user_creation_csv_download_url" {
  value = local_file.user_creation_csv.filename
}


