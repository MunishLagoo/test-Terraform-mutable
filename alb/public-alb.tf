resource "aws_lb" "public" {
  name               = "roboshop-public-${var.ENV}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public-alb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNETS_IDS

  enable_deletion_protection = false

  tags = {
    Environment = "roboshop-public-${var.ENV}"
  }
}

resource "aws_route53_record" "frontend-public" {
  zone_id = data.terraform_remote_state.vpc.outputs.INTERNAL_HOSTED_ZONEID
  name    = "roboshop-${var.ENV}"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.public.dns_name]
}