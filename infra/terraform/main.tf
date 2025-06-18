provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "exosuite" {
  ami           = "ami-08c40ec9ead489470"  # Amazon Linux 2 AMI (HVM)
  instance_type = "t3.medium"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 8001:8000 ghcr.io/youruser/primeengineai
              docker run -d -p 8002:8000 ghcr.io/youruser/factorengine
              docker run -d -p 8003:8000 ghcr.io/youruser/quantumhash
              EOF

  tags = {
    Name = "ExoSuiteStackNode"
  }
}

output "instance_public_ip" {
  value = aws_instance.exosuite.public_ip
}