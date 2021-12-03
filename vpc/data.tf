data "aws_route_tables" "default-vpc-route-table" {
  vpc_id = var.VPC_ID_DEFAULT
}

//******output of data
output "default-vpc-route-table" {
    value = data.aws_route_tables.default-vpc-route-table
}