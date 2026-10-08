output "honeypot_public_ip" {
  description = "Public IP address of the honeypot EC2 instance"
  value       = aws_instance.honeypot.public_ip
}

output "honeypot_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.honeypot.id
}

output "admin_ssh_command" {
  description = "SSH command for administrative access"
  value       = "ssh -i keys/cloud-honeypot-lab -p 22222 ubuntu@${aws_instance.honeypot.public_ip}"
}