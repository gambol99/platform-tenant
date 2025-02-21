# Makefile for the development clusters

default: dev

.PHONY: dev clean
dev:
	@./scripts/make-dev.sh

clean:
	@echo "Deleting development clusters..."
	@kind delete cluster --name grn >/dev/null || true
	@kind delete cluster --name yel >/dev/null || true