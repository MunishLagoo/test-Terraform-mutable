resource "aws_security_group" "ingress-efs" {
  name        = "roboshop-ingress_efs-${var.ENV}"
  description = "roboshop-ingress_efs-${var.ENV}"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "nfs-ingress"
      from_port        = 2049
      to_port          = 2049
      protocol         = "tcp"
      cidr_blocks      = local.ALL_VPC_CIDR
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "nfs-egress"
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
    Name = "roboshop-ingress-efs-${var.ENV}"
  }
}

resource "aws_efs_file_system" "efs-shared" {
    creation_token = "efs-shared"
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
    encrypted = "true"
tags = {
    Name = "EfsShared"
  }    
}

resource "aws_efs_mount_target" "efs-mt-shared" {
    file_system_id = aws_efs_file_system.efs-shared.id
    subnet_id = aws_subnet.private-subnet.*.id
    security_groups = [aws_security_group.ingress-efs.id]
}

resource "aws_efs_access_point" "efs-access-points" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user = {
        uid = 4000
        gid = 4000
    }

    root_directory = {
        path = "/apps/cart"
        creation_info = {
            owner_uid = 4000
            owner_gid = 4000
            permissions = "0755"
        }
    }
}