## PRIVATE PEM KEY ##
output "private_key" {
  value       = local_file.private_key.content
  description = "Private Pem Key"
  sensitive   = true
}

output "instance_id" {
  value       = aws_spot_instance_request.ec2_spot.*.spot_instance_id
  description = "EC2 IDs"
}

output "public_ip" {
  value = aws_spot_instance_request.ec2_spot.*.public_ip
}