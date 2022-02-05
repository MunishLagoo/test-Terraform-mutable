variable "ENV" {}
variable "EKS_CLUSTER" {}
variable "EKS_REGION" {}
variable "EKS_delete" {
type = "string"
default = "false"
description = "Used to delete EKS Cluster"
}
