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
  # Create the namespace 
  kubectl create namespace argocd --context "${cluster_context}" 2>/dev/null || true
  # Apply the tenant configuration for the specific cluster
  kubectl kustomize kustomize/overlays/${cluster_name} \
    --enable-helm=true --context "${cluster_context}" | kubectl apply -f -
}

# Main execution
echo "Provisioning development environment..."

setup_cluster "grn" || {
  echo "Failed to setup green cluster"
  exit 1
}

echo "Setup completed successfully! (currently on 'grn' cluster)"
