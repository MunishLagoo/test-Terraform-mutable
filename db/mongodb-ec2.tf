
//request spot instance
//wait for fulfilment option because it is spot instance
resource "aws_spot_instance_request" "mongodb" {
  ami           = data.aws_ami.ami.id
  instance_type = var.MONGODB_INSTANCE
  vpc_security_group_ids = [aws_security_group.mongodb.id]
  wait_for_fulfillment = true
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS[0]

  tags = {
    Name = "mongodb-${var.ENV}"
  }
}

resource "aws_ec2_tag" "mongodb" {
  resource_id = aws_spot_instance_request.mongodb.spot_instance_id
  key         = "Name"
  value       = "mongodb-${var.ENV}"
}

//create security group
//it is ec2 instance needs SSH port open
resource "aws_security_group" "mongodb" {
  name        = "mongodb-${var.ENV}"
  description = "mongodb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [
    {
      description      = "MONGODB"
      from_port        = 27016
      to_port          = 27016
      protocol         = "tcp"
      cidr_blocks      = local.ALL_CIDR
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = local.ALL_CIDR
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "mongodb-${var.ENV}"
  }
}

//create dns record
resource "aws_route53_record" "mongodb" {
  zone_id = data.terraform_remote_state.vpc.outputs.INTERNAL_HOSTED_ZONEID
  name    = "mongodb-${var.ENV}"
  type    = "A"
  ttl     = "300"
  records = [aws_spot_instance_request.mongodb.private_ip]
}

//install mongodb
//install ansible on mongodb node
# resource "null_resource" "mongodb" {
#     provisioner "remote-exec" {
#         connection {
#             host = aws_spot_instance_request.mongodb.private_ip
#             user = local.ssh_user
#             password = local.ssh_pass
#         }
#         inline = [
#         "sudo yum install python3-pip -y",
#         "sudo pip3 install pip --upgrade",
#         "sudo pip3 install ansible",
#         "ansible-pull -U https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps60/_git/ansible roboshop-pull.yml -e ENV=${var.ENV} -e COMPONENT=mongodb -e APP_VERSION="
#         ]
#     }
# }

//use base image already ansible installed
resource "null_resource" "mongodb" {
    provisioner "remote-exec" {
        connection {
            host = aws_spot_instance_request.mongodb.private_ip
            user = local.ssh_user
            password = local.ssh_pass
        }
        inline = [ 
            "ansible-pull -U https://github.com/MunishLagoo/test-ansible.git roboshop-pull.yml -e ENV=${var.ENV} -e COMPONENT=mongodb"
            ]
    }
}