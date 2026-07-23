variable "aws_region" {
  description = "AWS region where infrastructure will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used in resource names"
  type        = string
  default     = "infra_pilot"
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition = contains(
      ["dev", "qa", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, qa, or prod."
  }
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR range for the environment VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR."
  }
}

variable "availability_zone_count" {
  description = "Number of Availability Zones"
  type        = number
  default     = 3

  validation {
    condition = (
      var.availability_zone_count >= 2 &&
      var.availability_zone_count <= 3
    )

    error_message = "Availability zone count must be 2 or 3."
  }
}

variable "single_nat_gateway" {
  description = "Use one NAT Gateway instead of one per Availability Zone"
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "EC2 instance types for the application node group"
  type        = list(string)
}

variable "node_capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition = contains(
      ["ON_DEMAND", "SPOT"],
      var.node_capacity_type
    )

    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_min_size" {
  description = "Minimum managed node group size"
  type        = number
}

variable "node_desired_size" {
  description = "Desired managed node group size"
  type        = number
}

variable "node_max_size" {
  description = "Maximum managed node group size"
  type        = number
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the Kubernetes API endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs allowed to access the public Kubernetes API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "aws_profile" {
  description = "AWS CLI profile used for authentication"
  type        = string
}

variable "aws_role_arn" {
  description = "IAM role ARN Terraform should assume"
  type        = string
}
