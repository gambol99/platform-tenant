
## Provision a EKS cluster for the hub
module "eks" {
  source = "github.com/gambol99/terraform-aws-eks?ref=main"

  access_entries                 = local.access_entries
  cluster_enabled_log_types      = null
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_name                   = var.cluster_name
  enable_nat_gateway             = var.enable_nat_gateway
  nat_gateway_mode               = var.nat_gateway_mode
  private_subnet_netmask         = var.private_subnet_netmask
  public_subnet_netmask          = var.public_subnet_netmask
  tags                           = local.tags
  vpc_cidr                       = var.vpc_cidr
}

## Provision and bootstrap the platform using an tenant repository
module "platform" {
  source = "github.com/gambol99/terraform-aws-eks//modules/platform?ref=main"

  tenant_repository = var.tenant_repository
  # You pretty much always want to use the HEAD
  tenant_branch = var.tenant_branch

  depends_on = [
    module.eks
  ]
}
