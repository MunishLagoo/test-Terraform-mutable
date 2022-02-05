resource "null_resource" "eks_delete_cluster" {
    count = "${var.EKS_delete} ? 1 : 0"
    provisioner "local-exec" {
        command = "eksctl delete cluster --name ${var.ENV}-${var.EKS_CLUSTER} --region ${var.EKS_REGION}"
    }
}
