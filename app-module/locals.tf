locals{
VPC_CIDR_DEFAULT = split(",",data.terraform_remote_state.vpc.outputs.VPC_CIDR_DEFAULT)
ALL_VPC_CIDR = data.terraform_remote_state.vpc.outputs.ALL_VPC_CIDR
ALL_CIDR = concat(local.VPC_CIDR_DEFAULT,data.terraform_remote_state.vpc.outputs.ALL_VPC_CIDR)
ssh_user = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["SSH_USER"]
ssh_pass = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["SSH_PASS"]
INSTANCE_IDS = concat(aws_spot_instance_request.spot.*.spot_instance_id,aws_instance.od.*.id)
PRIVATE_IPS = concat(aws_spot_instance_request.spot.*.private_ip,aws_instance.od.*.private_ip)
tags = {NAME = "${var.COMPONENT}-${var.ENV}"}
}