locals{
    EKS_PRIVATE_SUBNET = join(",",data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS)
    EKS_PUBLIC_SUBNET = join(",",data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS)
}