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
    subnet_id = aws_subnet.private-subnet.*.id[0]
    security_groups = [aws_security_group.ingress-efs.id]
}

resource "aws_efs_access_point" "efs-cart" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4000
        gid = 4000
    }

    root_directory  {
        path = "/apps/cart"
        creation_info  {
            owner_uid = 4000
            owner_gid = 4000
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-user" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4001
        gid = 4001
    }

    root_directory  {
        path = "/apps/user"
        creation_info  {
            owner_uid = 4001
            owner_gid = 4001
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-shipping" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4002
        gid = 4002
    }

    root_directory  {
        path = "/apps/shipping"
        creation_info  {
            owner_uid = 4002
            owner_gid = 4002
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-payment" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4003
        gid = 4003
    }

    root_directory  {
        path = "/apps/payment"
        creation_info  {
            owner_uid = 4003
            owner_gid = 4003
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-catalogue" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4004
        gid = 4004
    }

    root_directory  {
        path = "/apps/catalogue"
        creation_info  {
            owner_uid = 4004
            owner_gid = 4004
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-frontend" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 4005
        gid = 4005
    }

    root_directory  {
        path = "/apps/frontend"
        creation_info  {
            owner_uid = 4005
            owner_gid = 4005
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-db-mysql" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 5000
        gid = 5000
    }

    root_directory  {
        path = "/db/mysql"
        creation_info  {
            owner_uid = 5000
            owner_gid = 5000
            permissions = "0755"
        }
    }
}

resource "aws_efs_access_point" "efs-db-mongodb" {
    file_system_id = aws_efs_file_system.efs-shared.id
    posix_user  {
        uid = 5001
        gid = 5001
    }

    root_directory  {
        path = "/db/mongo"
        creation_info  {
            owner_uid = 5001
            owner_gid = 5001
            permissions = "0755"
        }
    }
}