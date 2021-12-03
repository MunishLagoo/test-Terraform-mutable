resource "aws_subnet" "subnet" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.addon]
  count      = length(var.SUBNETS)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.SUBNETS,count.index)
  availability_zone = element(var.AZS,count.index)

  tags = {
    Name = "subnet-${var.ENV}-${count.index}"
  }
}

resource "aws_route_table_association" "subnet" {
  count          = length(aws_subnet.subnet.*.id)
  subnet_id      = element(aws_subnet.subnet.*.id,count.index)
  route_table_id = aws_route_table.private-route.id
}