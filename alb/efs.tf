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
    subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS
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