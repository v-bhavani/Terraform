provider "aws" {
  region = var.aws_region
}

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size              = var.volume_size

  // Uncomment below if you want to create a snapshot of the volume
  // snapshot_id = var.snapshot_id
}
