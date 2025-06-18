# ExoSuite Terraform Deployment

## Prerequisites

- AWS account with access/secret key
- AWS CLI configured (`aws configure`)
- Terraform installed

## Deploy

```bash
cd infra/terraform
terraform init
terraform apply
```

Once deployed, access:

- PrimeEngineAI: http://<instance-ip>:8001
- FactorEngine: http://<instance-ip>:8002
- QuantumHash: http://<instance-ip>:8003
```

The scripts auto-install Docker and run 3 containerized services on EC2.

## Optional: Enable HTTPS with Route53 + ACM

- Configure your domain in `terraform.tfvars`
- Ensure your AWS account has Route53 permissions
- Deploy using `terraform apply`

This will enable HTTPS load balancing at `https://your-domain.com`
