//This Resource creates Route table with Routes
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.main.id

  route  = [{
    cidr_block                      = var.VPC_CIDR_DEFAULT
    vpc_peering_connection_id       = aws_vpc_peering_connection.peer.id
    "carrier_gateway_id"            = ""
    "destination_prefix_list_id"    = ""
    "egress_only_gateway_id"        = ""
    "gateway_id"                    = ""
    "instance_id"                   = ""
    "ipv6_cidr_block"               = ""
    "local_gateway_id"              = ""
    "nat_gateway_id"                = ""
    "network_interface_id"          = ""   
    "transit_gateway_id"            = ""
    "vpc_endpoint_id"               = ""
  }]

  tags = {
    Name                            = "private-route"
  }
}

resource "aws_route" "route_from_default_vpc" {
    count                   = length(local.association-list)
  route_table_id            = tomap(element(local.association-list,count.index))["route-table"]
  destination_cidr_block    = tomap(element(local.association-list,count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  
}
