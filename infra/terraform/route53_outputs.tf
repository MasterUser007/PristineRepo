output "exosuite_domain" {
  description = "Domain name of the ALB endpoint"
  value       = aws_route53_zone.main.name
}