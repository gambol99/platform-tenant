
locals {
  ## The cluster configuration
  cluster = yamldecode(file(var.cluster_path))
  ## The cluster_name of the cluster
  cluster_name = local.cluster.cluster_name
  ## The cluster type
  cluster_type = local.cluster.cluster_type
  ## The platform repository
  platform_repository = local.cluster.platform_repository
  ## The platform revision
  platform_revision = local.cluster.platform_revision
  ## The tenant repository
  tenant_repository = local.cluster.tenant_repository
  ## The tenant revision
  tenant_revision = local.cluster.tenant_revision
  ## The tenant path
  tenant_path = local.cluster.tenant_path
  ## Indicates if we install the platorm - we do for a hub or standalone cluster type
  enable_platform = contains(["hub", "standalone"], local.cluster_type) ? true : false
}

## Provision a EKS cluster for the hub
module "eks" {
  source = "github.com/gambol99/terraform-aws-eks?ref=v0.1.1"

  access_entries                 = local.access_entries
  cluster_enabled_log_types      = null
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_name                   = local.cluster_name
  eks_managed_node_groups        = {}
  enable_auto_mode               = true
  enable_argocd_pod_identity     = (local.cluster_type == "hub" ? true : false)
  enable_nat_gateway             = var.enable_nat_gateway
  hub_account_id                 = var.hub_account_id
  nat_gateway_mode               = var.nat_gateway_mode
  private_subnet_netmask         = var.private_subnet_netmask
  public_subnet_netmask          = var.public_subnet_netmask
  tags                           = local.tags
  vpc_cidr                       = var.vpc_cidr
}

## Provision and bootstrap the platform using an tenant repository
module "platform" {
  count  = local.enable_platform ? 1 : 0
  source = "github.com/gambol99/terraform-aws-eks//modules/platform?ref=v0.1.1"

  ## Name of the cluster
  cluster_name = local.cluster_name
  # The type of cluster
  cluster_type = local.cluster_type
  # Any rrepositories to be provisioned
  repositories = var.argocd_repositories
  ## The platform repository
  platform_repository = local.platform_repository
  # The location of the platform repository
  platform_revision = local.platform_revision
  # The location of the tenant repository
  tenant_repository = local.tenant_repository
  # You pretty much always want to use the HEAD
  tenant_revision = local.tenant_revision
  ## The tenant repository path
  tenant_path = local.tenant_path

  depends_on = [
    module.eks
  ]
}
