locals{
    EKS_PRIVATE_SUBNET = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS[0]
    EKS_PUBLIC_SUBNET = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS[0]
}