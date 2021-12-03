//NAT gateway needs elastic Ip to connect to IGW
//allocation_id
resource "aws_eip" "ngw" {
  vpc      = true

  tags = {
      Name = "${var.ENV}-ngw-ip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id = var.PRIVATE_SUBNETS.*.id[0]

  tags = {
    Name = "${var.ENV}-ngw"
  }
}