resource "null_resource" "eks_test_vpc" {
    provisioner "local-exec" {
        command = "eksctl create cluster --name ${var.ENV}-${var.EKS_CLUSTER} --region ${var.EKS_REGION} --managed --vpc-private-subnets=data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS --vpc-public-subnets=data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS"
    }
}