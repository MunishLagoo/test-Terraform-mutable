ENV= "dev"
EKS_CLUSTER = "eks-cluster"
EKS_REGION = "us-east-1"
EKS_PRIVATE_SUBNET = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS
EKS_PUBLIC_SUBNET = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS