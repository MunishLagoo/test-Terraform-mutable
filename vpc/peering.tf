resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = var.VPC_ID_DEFAULT
  auto_accept   = true

 tags = {
    Name = "peer-${var.ENV}-vpc-to-default-vpc"
  }
  }