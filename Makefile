# Makefile for the clusters

default: local

.PHONY: local clean
local:
	@echo "--> Provisioning development environment (local)"
	@./scripts/make-local.sh --cluster-name dev

dev:
	@echo "--> Provisioning dev cluster..."
	@cd terraform && terraform init
	@cd terraform && terraform apply -auto-approve

dev-destroy:
	@echo "--> Destroying dev cluster..."
	@cd terraform && terraform destroy -auto-approve

destroy-local:
	@echo "--> Destroying development environment..."
	@kind delete cluster --name dev > /dev/null 2>&1 || true

clean:
	@echo "--> Cleaning up..."
	@rm -rf terraform/.terraform
	@rm -rf terraform/.terraform.lock.hcl
	@$(MAKE) destroy-local
