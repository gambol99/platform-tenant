# Makefile for the clusters

default: dev

.PHONY: dev clean
dev:
	@echo "--> Provisioning development environment..."
	@./scripts/make-environment.sh --cluster-name dev 

prod:
	@echo "--> Provisioning production environment..."
	@./scripts/make-environment.sh --cluster-name prod

destroy-dev:
	@echo "--> Destroying development environment..."
	@./scripts/make-environment.sh --cluster-name dev --destroy

destroy-prod:
	@echo "--> Destroying production environment..."
	@./scripts/make-environment.sh --cluster-name prod --destroy

destroy:
	@(MAKE) destroy-dev 
	@(MAKE) destroy-prod

clean:
	@echo "--> Cleaning up..."
	@rm -rf terraform/.terraform
	@rm -rf terraform/.terraform.lock.hcl
	@(MAKE) destroy
	


