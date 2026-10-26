resource "aws_lb" "this" {
  name = substr("${var.project_name}-${var.environment}-alb", 0, 32)
  internal = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]
  subnets = var.public_subnet_ids
  tags = var.tags
}
resource "aws_lb_target_group" "this" {
  name = substr("${var.project_name}-${var.environment}-tg", 0, 32)
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check { path = "/"; matcher = "200-399"; interval = 30; healthy_threshold = 2; unhealthy_threshold = 3 }
  tags = var.tags
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port = 80
  protocol = "HTTP"
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.this.arn }
}
resource "aws_launch_template" "this" {
  name_prefix = "${var.project_name}-${var.environment}-"
  image_id = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.instance_sg_id]
  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -eux
    dnf install -y nginx
    systemctl enable --now nginx
    echo "Hello from ${var.project_name} (${var.environment})" > /usr/share/nginx/html/index.html
  EOF
  )
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-web" })
  }
}
resource "aws_autoscaling_group" "this" {
  name = "${var.project_name}-${var.environment}-asg"
  min_size = var.environment == "prod" ? 2 : 1
  desired_capacity = var.environment == "prod" ? 2 : 1
  max_size = var.environment == "prod" ? 4 : 2
  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns = [aws_lb_target_group.this.arn]
  health_check_type = "ELB"
  health_check_grace_period = 180
  launch_template { id = aws_launch_template.this.id; version = "$Latest" }
  dynamic "tag" {
    for_each = var.tags
    content { key = tag.key; value = tag.value; propagate_at_launch = true }
  }
}
