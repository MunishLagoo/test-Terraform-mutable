//loop in a loop 
//2 Route Tables and 2 CIDR that makes 4 Combinations
//each route table should have both CIDR
locals{
association-list = flatten([
    for route_table in tolist(data.aws_route_tables.default-vpc-routes.ids):[
        for cidr in local.ALL_VPC_CIDR: {
            route_table = route_table
            cidr = cidr
        }
    ]
])
}

//create a list of all the CIDR, 
//main is string and ADDON is list

locals{
    VPC_CIDR_MAIN = split(",",var.VPC_CIDR_MAIN)
    ALL_VPC_CIDR = concat(var.VPC_CIDR_ADDON,local.VPC_CIDR_MAIN)
}



//*******outputs of these local variables
//output "sample" {
//    value = local.association-list
//}

//output "ALL_VPC_CIDR" {
//    value = [for s in local.ALL_VPC_CIDR:"CIDR = ${s}"]
//}