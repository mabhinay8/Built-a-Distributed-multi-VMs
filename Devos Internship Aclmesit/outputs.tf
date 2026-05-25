output "gateway_public_ip" {
  description = "Public IP of the API gateway"
  value       = aws_instance.gateway.public_ip
}

output "worker_private_ips" {
  description = "Private IPs of worker instances"
  value       = [for w in aws_instance.worker : w.private_ip]
}

output "vpc_id" {
  value = aws_vpc.main.id
}