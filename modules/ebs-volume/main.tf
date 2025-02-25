
resource "aws_ebs_volume" "this" {
  count             = var.volume_count
  availability_zone = var.availability_zone
  size             = var.volume_size
  type             = var.volume_type

  tags = {
    Name = "${var.instance_name}-volume-${count.index + 1}"
  }
}

resource "aws_volume_attachment" "this" {
  count       = var.volume_count
  device_name = "/dev/sd${char(120 + count.index)}"  # x, y, z...
  volume_id   = aws_ebs_volume.this[count.index].id
  instance_id = var.instance_id
}
