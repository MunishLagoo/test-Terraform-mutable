resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block = var.VPC_ID_DEFAULT
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "example"
  }
}

