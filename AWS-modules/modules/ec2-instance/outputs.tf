output "instance_id" {
  value = aws_instance.this.id
}

output "availability_zone" {
  value = aws_instance.this.availability_zone
}
