# Terraform

This folder contains the Terraform configuration for provisioning an EKS cluster and bootstrapping it with the Kubernetes platform. The code here is provided as an example implementation only, and not reflective of a production grade deployment.

The Terraform code will:

- Create a new EKS cluster in AWS
- Configure the necessary networking and IAM roles
- Bootstrap the cluster with the platform components
- Set up initial GitOps configuration

Note: This is intended as a reference implementation. For production use, you should carefully review and customize the configuration according to your requirements.

## Provision a Development Cluster

You can provision a development cluster using

```shell
terraform apply -var-file=variables/dev.tfvars
```
