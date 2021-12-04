locals{
VPC_CIDR_DEFAULT = split(",",data.terraform_remote_state.vpc.outputs.VPC_CIDR_DEFAULT)
ALL_CIDR = concat(local.VPC_CIDR_DEFAULT,data.terraform_remote_state.vpc.outputs.ALL_VPC_CIDR)
}