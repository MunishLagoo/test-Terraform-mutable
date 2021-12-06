resource "aws_subnet" "private-subnet" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.addon]
  count      = length(var.PRIVATE_SUBNETS)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.PRIVATE_SUBNETS,count.index)
  availability_zone = element(var.AZS,count.index)

  tags = {
    Name = "private-subnet-${var.ENV}-${count.index}"
  }
}

resource "aws_subnet" "public-subnet" {
  depends_on = [aws_vpc_ipv4_cidr_block_association.addon]
  count = length(var.PUBLIC_SUBNETS)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.PUBLIC_SUBNETS,count.index)
  availability_zone = element(var.AZS,count.index)

  tags = {
    Name = "public-subnet-${var.ENV}-${count.index}"
  }
}

resource "aws_route_table_association" "private-subnet" {
  count          = length(aws_subnet.private-subnet.*.id)
  subnet_id      = element(aws_subnet.private-subnet.*.id,count.index)
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "public-subnet" {
  count           = length(aws_subnet.public-subnet.*.id)
  subnet_id       = element(aws_subnet.public-subnet.*.id,count.index)
  route_table_id  = aws_route_table.public-route.id
<<<<<<< HEAD
}
=======
}
>>>>>>> 8ec26cd270f669793154d03007d334dcce5916c9
