resource "null_resource" "eks_test_vpc" {
    export s1 = aws_subnet.private-subnet.*.id
    provisioner "local-exec" {
        command = "eksctl create cluster --name ${var.ENV}-${var.EKS_CLUSTER} --region ${var.EKS_REGION} --managed --vpc-private-subnets=aws_subnet.private-subnet.*.id --vpc-public-subnets=data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS"
    }
}


data.terraform_remote_state.vpc.outputs.VPC_CIDR_DEFAULT