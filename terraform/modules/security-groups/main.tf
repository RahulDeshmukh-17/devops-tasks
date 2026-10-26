resource "aws_security_group" "alb" {
  name = "${var.project_name}-${var.environment}-alb-sg"
  description = "Allow HTTP to ALB"
  vpc_id = var.vpc_id
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
  tags = var.tags
}
resource "aws_security_group" "instance" {
  name = "${var.project_name}-${var.environment}-instance-sg"
  description = "Allow HTTP from ALB; optional restricted SSH"
  vpc_id = var.vpc_id
  ingress {
    from_port = 80; to_port = 80; protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  dynamic "ingress" {
    for_each = var.ssh_allowed_cidr == "" ? [] : [var.ssh_allowed_cidr]
    content {
      from_port = 22; to_port = 22; protocol = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
  tags = var.tags
}
