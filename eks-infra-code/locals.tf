data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  cluster_name = "${var.project_name}-${var.environment}"

  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    var.availability_zone_count
  )

  public_subnets = [
    for index in range(var.availability_zone_count) :
    cidrsubnet(var.vpc_cidr, 8, index + 1)
  ]

  private_subnets = [
    for index in range(var.availability_zone_count) :
    cidrsubnet(var.vpc_cidr, 8, index + 11)
  ]

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "eks-infra"
  }
}
