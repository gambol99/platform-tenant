# EKS Tenant Example Repository

## Overview

This repository provides an example implementation of a multi-tenant EKS cluster setup. It demonstrates how to:

- Deploy and manage tenant-specific EKS clusters
- Configure cluster settings via YAML definitions in `clusters/`
- Apply infrastructure as code using Terraform
- Bootstrap platform components from a tenant repository

You can see view the platform here: https://github.com/gambol99/kubernetes-platform

## Structure

- `clusters/` - Contains cluster configuration YAML files
- `clusters/hub` - Contains the cluster definitions for a hub and spoke deployment model.
- `workloads` - Contains the application workloads to deploy to the clusters.
- `terraform/` - Infrastructure code for provisioning EKS clusters
  - Creates VPC, subnets, and EKS cluster
  - Bootstraps platform components from tenant repository

## Usage

1. Configure cluster settings in `clusters/<environment>.yaml`
2. Apply Terraform configuration in `terraform/` directory
3. Platform components will be automatically bootstrapped from the tenant repository

See individual directory READMEs for more detailed documentation.
