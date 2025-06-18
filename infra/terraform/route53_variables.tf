variable "domain_name" {
  type        = string
  description = "Domain name to register"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the load balancer"
}

variable "lb_security_group_id" {
  type        = string
  description = "Security group ID for the ALB"
}