environment        = "dev"
aws_region         = "us-east-1"
project_name       = "eks-python"
kubernetes_version = "1.34"

vpc_cidr = "10.20.0.0/16"

availability_zone_count = 2
single_nat_gateway      = true

node_instance_types = [
  "t3.small"
]

node_capacity_type = "ON_DEMAND"

node_min_size     = 1
node_desired_size = 1
node_max_size     = 2

cluster_endpoint_public_access = true

cluster_endpoint_public_access_cidrs = [
  "0.0.0.0/0"
]
