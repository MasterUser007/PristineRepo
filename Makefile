# ExoSuite Cloud Deployment Makefile

init:
	cd infra/terraform && terraform init

plan:
	cd infra/terraform && terraform plan

apply:
	cd infra/terraform && terraform apply -auto-approve

destroy:
	cd infra/terraform && terraform destroy -auto-approve

refresh:
	cd infra/terraform && terraform refresh

output:
	cd infra/terraform && terraform output

all: init apply output

# ExoSuite Monitoring Automation

monitoring-up:
	docker-compose -f docker-compose.prometheus.yml up --build -d

monitoring-down:
	docker-compose -f docker-compose.prometheus.yml down

monitoring-logs:
	docker-compose -f docker-compose.prometheus.yml logs -f