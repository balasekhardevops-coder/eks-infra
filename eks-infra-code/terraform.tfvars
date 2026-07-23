aws_region         = "us-east-1"
project_name       = "eks-python"
environment        = "dev"
cluster_name       = "eks-python-cluster"
kubernetes_version = "1.32"
vpc_cidr           = "10.20.0.0/16"

node_instance_types = [
  "t3.medium"
]
