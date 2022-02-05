resource "null_resource" "eks_test_vpc" {
    provisioner "local-exec" {
        command = "eksctl create cluster --name ${var.ENV}-${var.EKS_CLUSTER} --region ${var.EKS_REGION} --managed --vpc-private-subnets=${var.EKS_PRIVATE_SUBNET} --vpc-public-subnets=${var.EKS_PUBLIC_SUBNET}"
    }
}
