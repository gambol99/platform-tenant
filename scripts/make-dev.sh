#!/usr/bin/env bash
#
# Script to provision clusters, install ArgoCD, and apply Kustomize configurations

set -euo pipefail

# Function to setup a cluster
setup_cluster() {
  local cluster_name=$1
  local cluster_context="kind-${cluster_name}"

  echo "Provisioning cluster: ${cluster_name}"
  # Create cluster (ignore error if exists)
  kind create cluster --name "${cluster_name}" 2>/dev/null || true
  # Create ArgoCD namespace (ignore error if exists)
  kubectl create namespace argocd --context "${cluster_context}" 2>/dev/null || true
  # Install ArgoCD
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --context "${cluster_context}" > /dev/null
  # Apply the tenant configuration for the specific cluster
  echo "Applying tenant configuration for ${cluster_name}"
  ## Create a symlink to the kustomize directory
  cp clusters/${cluster_name}.yaml kustomize/overlays/${cluster_name}/platform.yaml
  # Apply the tenant configuration for the specific cluster
  kubectl apply -k kustomize/overlays/${cluster_name} --context "${cluster_context}"
}

# Main execution
echo "Provisioning development environment..."

setup_cluster "grn" || {
  echo "Failed to setup green cluster"
  exit 1
}

echo "Setup completed successfully! (currently on 'grn' cluster)"
