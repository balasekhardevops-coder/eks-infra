module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${local.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = local.availability_zones
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = var.single_nat_gateway

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = merge(
    local.common_tags,
    {
      "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    }
  )
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.cluster_name
  kubernetes_version = var.kubernetes_version

  endpoint_public_access       = var.cluster_endpoint_public_access
  endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  authentication_mode = "API_AND_CONFIG_MAP"

  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  control_plane_subnet_ids = module.vpc.private_subnets

  addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent    = true
      before_compute = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }

    metrics-server = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    application = {
      name = "${local.cluster_name}-app"

      instance_types = var.node_instance_types
      capacity_type  = var.node_capacity_type

      min_size     = var.node_min_size
      desired_size = var.node_desired_size
      max_size     = var.node_max_size

      subnet_ids = module.vpc.private_subnets

      labels = {
        workload    = "application"
        environment = var.environment
      }

      update_config = {
        max_unavailable_percentage = 33
      }

      tags = merge(
        local.common_tags,
        {
          NodeGroup = "application"
        }
      )
    }
  }

  tags = local.common_tags
}
