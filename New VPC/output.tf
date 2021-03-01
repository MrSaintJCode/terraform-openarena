output "workspace_nat_gateway_1a" {
  description = "NAT - 1a"
  value = aws_eip.workspace_eip_nat_1a.public_ip
}

output "workspace_nat_gateway_1b" {
  description = "NAT - 1b"
  value = aws_eip.workspace_eip_nat_1b.public_ip
}

# Load Balancer
output "openarena_dns_lb" {
  description = "DNS load balancer"
  value = aws_alb.openarena_lb.dns_name
}