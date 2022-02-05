resource "null_resource" "eks_test_vpc" {
    provisioner "local-exec" {
        command = "eksctl create cluster --name var.ENV-var.EKS_CLUSTER --region var.EKS_REGION --managed --vpc-private-subnets=aws_subnet.private-subnet.*.id[0] --vpc-public-subnets=aws_subnet.public-subnet.*.id[0]"
    }
}