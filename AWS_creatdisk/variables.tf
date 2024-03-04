variable "aws_region" {
  description = "AWS region where the EBS volume will be created"
}

variable "availability_zone" {
  description = "AWS availability zone where the EBS volume will be created"
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
}

// Uncomment below if you want to use an existing snapshot
// variable "snapshot_id" {
//   description = "ID of the snapshot to use for the EBS volume"
// }
