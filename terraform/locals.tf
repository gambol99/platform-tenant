
locals {
  ## The account ID of the hub
  account_id = data.aws_caller_identity.current.account_id
  ## The SSO Administrator role ARN
  sso_role_name = var.sso_role_name
  ## Collection of tags to apply to resources
  tags = merge(var.tags, {})

  ## EKS Access Entries for authentication
  access_entries = {
    admin = {
      principal_arn = format("arn:aws:iam::%s:role/aws-reserved/sso.amazonaws.com/eu-west-2/%s", local.account_id, local.sso_role_name)
      policy_associations = {
        cluster_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}

