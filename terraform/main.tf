
## Provision a EKS cluster for the hub
module "eks" {
  #source = "github.com/gambol99/terraform-aws-eks?ref=main"
  source = "../../terraform-aws-eks"

  access_entries                 = local.access_entries
  cluster_enabled_log_types      = null
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_name                   = var.cluster_name
  eks_managed_node_groups        = {}
  enable_auto_mode               = true
  enable_nat_gateway             = var.enable_nat_gateway
  nat_gateway_mode               = var.nat_gateway_mode
  private_subnet_netmask         = var.private_subnet_netmask
  public_subnet_netmask          = var.public_subnet_netmask
  tags                           = local.tags
  vpc_cidr                       = var.vpc_cidr
}

## Provision and bootstrap the platform using an tenant repository
module "platform" {
  #source = "github.com/gambol99/terraform-aws-eks//modules/platform?ref=main"
  source = "../../terraform-aws-eks/modules/platform"

  ## Name of the cluster
  cluster_name = var.cluster_name
  # The type of cluster
  cluster_type = var.cluster_type
  # The location of the tenant repository
  tenant_repository = var.tenant_repository
  # You pretty much always want to use the HEAD
  tenant_revision = var.tenant_revision

  depends_on = [
    module.eks
  ]
}
