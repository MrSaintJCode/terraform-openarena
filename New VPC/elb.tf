resource "aws_alb" "openarena_lb" {
  name = "${terraform.workspace}-lb"
  subnets = [aws_subnet.workspace_public_subnet_1a.id,
             aws_subnet.workspace_public_subnet_1b.id]
  idle_timeout = 600
  load_balancer_type = "network"
  enable_deletion_protection = true

  tags = {
    Name = "${terraform.workspace}-lb"
  }
}

resource "aws_alb_listener" "openarena_listener" {
  load_balancer_arn = aws_alb.openarena_lb.id
  port = 27960
  protocol = "UDP"
  default_action {
    target_group_arn = aws_alb_target_group.openarena_tg.id
    type = "forward"
  }
}

resource "aws_alb_target_group" "openarena_tg" {
  name = "${terraform.workspace}-tg"
  port = 27960
  protocol = "UDP"
  vpc_id = aws_vpc.workspace_vpc.id
  target_type = "ip"
  tags = {
    Name = "${terraform.workspace}-tg"
  }
}