
variable "tags" {
  description = "The tags to apply to all resources"
  type        = map(string)
}

variable "sso_role_name" {
  description = "The SSO Administrator role ARN"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "cluster_type" {
  description = "The type of cluster to create"
  type        = string
  default     = "standalone"
}

variable "tenant_repository" {
  description = "The repository to use for the tenant"
  type        = string
  default     = "https://github.com/gambol99/eks-tenant"
}

variable "tenant_branch" {
  description = "The branch to use for the tenant"
  type        = string
  default     = "main"
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

