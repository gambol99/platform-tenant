
variable "tags" {
  description = "The tags to apply to all resources"
  type        = map(string)
}

variable "sso_role_name" {
  description = "The SSO Administrator role ARN"
  type        = string
}

variable "hub_account_id" {
  description = "When using a hub deployment options, this is the account where argocd is running"
  type        = string
  default     = null
}

variable "cluster_path" {
  description = "The name of the cluster"
  type        = string
}

variable "private_subnet_netmask" {
  description = "The netmask for the private subnets"
  type        = number
  default     = 24
}

variable "public_subnet_netmask" {
  description = "The netmask for the public subnets"
  type        = number
  default     = 24
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.90.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Enable the NAT gateway"
  type        = bool
  default     = true
}

variable "nat_gateway_mode" {
  description = "The NAT gateway mode"
  type        = string
  default     = "single_az"
}

variable "cluster_endpoint_public_access" {
  description = "The public access to the cluster endpoint"
  type        = bool
  default     = true
}

variable "argocd_repositories" {
  description = "A collection of repository secrets to add to the argocd namespace"
  type = map(object({
    ## The description of the repository
    description = string
    ## The secret to use for the repository
    secret = optional(string, null)
    ## The secret manager ARN to use for the secret
    secret_manager_arn = optional(string, null)
    ## An optional SSH private key for the repository
    ssh_private_key = optional(string, null)
    ## The URL of the repository
    url = string
    ## An optional username for the repository
    username = optional(string, null)
    ## An optional password for the repository
    password = optional(string, null)
  }))
  default = {}
}

