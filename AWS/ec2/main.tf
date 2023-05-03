provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_ebs_volume" "example" {
  availability_zone = "${var.avai_zone}"
  size              = "${var.vol_size}"

  tags = {
    Name = "${var.volume_tag}"
  }
}
