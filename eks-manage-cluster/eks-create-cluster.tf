resource "null_resource" "eks_create_cluster" {
    provisioner "local-exec" {
        command = "eksctl create cluster --name ${var.ENV}-${var.EKS_CLUSTER} --region ${var.EKS_REGION} --managed --vpc-private-subnets=${local.EKS_PRIVATE_SUBNET} --vpc-public-subnets=${local.EKS_PUBLIC_SUBNET}"
    }
}
