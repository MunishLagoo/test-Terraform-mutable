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
    Name = cart
    file_system_id = aws_efs_file_system.efs-shared.id
    PosixUser = {
        Uid = 4000
        Gid = 4000
    }

    RootDirectory = {
        Path = "/apps/cart"
        CreationInfo = {
            OwnerUid = 4000
            OwnerGid = 4000
            Permissions = 0755
        }
    }
}