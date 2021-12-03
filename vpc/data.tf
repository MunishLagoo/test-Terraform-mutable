data "aws_route_tables" "default-vpc-routes" {
  vpc_id = var.VPC_ID_DEFAULT
}

//******output of data
output "default-vpc-routes" {
    value = data.aws_route_tables.default-vpc-routes
}