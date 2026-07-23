output "environment" {
  description = "Environment deployed by Terraform"
  value       = var.environment
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API endpoint"
  value       = module.eks.cluster_endpoint
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "vpc_id" {
  description = "Environment VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "node_security_group_id" {
  description = "EKS worker node security group"
  value       = module.eks.node_security_group_id
}

output "kubectl_update_command" {
  description = "Command used to update kubeconfig"
  value = join(
    " ",
    [
      "aws eks update-kubeconfig",
      "--region",
      var.aws_region,
      "--name",
      module.eks.cluster_name
    ]
  )
}
