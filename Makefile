# Makefile for the development clusters

default: dev

.PHONY: dev clean
dev:
	@./scripts/make-dev.sh

clean:
	@echo "Deleting development clusters..."
	@kind delete cluster --name grn >/dev/null || true

lint: 
	@echo "Linting the tenant cluster..."
	$(MAKE) lint-platform-applications

lint-plaform-applications:
	@echo "Linting the platform applications..."
	@kubeconform \
		-ignore-missing-schemas \
		-schema-location https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/kustomize/base/kustomize.yaml \
		-f kustomize/base

