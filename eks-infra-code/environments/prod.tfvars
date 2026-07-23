environment        = "prod"
aws_region         = "us-east-1"
project_name       = "eks-python"
kubernetes_version = "1.34"

vpc_cidr = "10.40.0.0/16"

availability_zone_count = 3

# Creates one NAT Gateway per Availability Zone.
single_nat_gateway = false

node_instance_types = [
  "m6i.large"
]

node_capacity_type = "ON_DEMAND"

node_min_size     = 3
node_desired_size = 3
node_max_size     = 10

cluster_endpoint_public_access = true

cluster_endpoint_public_access_cidrs = [
  "203.0.113.10/32"
]
