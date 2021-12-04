locals {
rds_mysqlUser = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_USER"]
rds_mysqlPass = jsondecode(data.aws_secretsmanager_secret_version.secrets-version.secret_string)["RDS_MYSQL_PASS"]
}

//Create RDS mysql service
resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  identifier             = "mysql-${var.ENV}"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "dummy"
  username               = local.rds_mysqlUser
  password               = local.rds_mysqlPass
  parameter_group_name   = aws_db_parameter_group.pg.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.mysql.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet-gp.name
}

//Security Group
resource "aws_security_group" "mysql" {
  name        = "mysql-${var.ENV}"
  description = "mysql-${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description      = "MYSQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = local.ALL_CIDR
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = {
    Name = "mysql-${var.ENV}"
  }
}

//Subnet Group
resource "aws_db_subnet_group" "subnet-gp" {
  name       = "mysql-subnet-gp-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS

  tags = {
    Name = "mysql-subnet-gp-${var.ENV}"
  }
}

//Parameter Group
resource "aws_db_parameter_group" "pg" {
  name   = "mysql-${var.ENV}-pg"
  family = "mysql5.7"

/*  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
  */
}

//create a CNAME record for Internal DNS
resource "aws_route53_record" "mysql" {
  zone_id = data.terraform_remote_state.vpc.outputs.INTERNAL_HOSTED_ZONEID
  name    = "mysql-${var.ENV}"
  type    = "CNAME"
  ttl     = "300"
  records = ["aws_db_instance.mysql.address"]
}


//Load Schema to DB

resource "null_resource" "mysql" {
provisioner  "local-exec" {
command = <<EOF
sudo yum install mariadb -y
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
cd /tmp
unzip -o /tmp/mysql.zip
mysql -h${aws_db_instance.mysql.address} -u${local.rds_mysqlUser} -p${local.rds_mysqlPass} <mysql-main/shipping.sql
EOF
}
}