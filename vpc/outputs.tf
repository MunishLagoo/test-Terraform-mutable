output "VPC_ID_DEFAULT" {
value = var.VPC_ID_DEFAULT
}
output "VPC_ID" {
value = aws_vpc.main.id
} 
output "PRIVATE_SUBNETS_IDS" {
value= aws_subnet.private-subnet.*.id
}
output "PUBLIC_SUBNETS_IDS" {
value= aws_subnet.public-subnet.*.id
}
output "PRIVATE_SUBNET_CIDR" {
value= aws_subnet.private-subnet.*.cidr_block
}
output "PUBLIC_SUBNET_CIDR" {
value = aws_subnet.public-subnet.*.cidr_block
}
output "VPC_CIDR_DEFAULT" {
value = var.VPC_CIDR_DEFAULT
}
output "INTERNAL_HOSTED_ZONEID" {
value = var.INTERNAL_HOSTED_ZONEID
}
output "ALL_VPC_CIDR" {
value = local.ALL_VPC_CIDR
}