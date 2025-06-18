output "exosuite_ip" {
  description = "Public IP of the ExoSuite instance"
  value       = aws_instance.exosuite.public_ip
}