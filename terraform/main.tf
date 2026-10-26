locals {
  tags = { Project = var.project_name, Environment = var.environment, ManagedBy = "Terraform" }
  instance_type = coalesce(var.instance_type, var.environment == "prod" ? "t3.medium" : "t2.micro")
}
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  tags = local.tags
}
module "security_groups" {
  source = "./modules/security-groups"
  project_name = var.project_name
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  tags = local.tags
}
module "asg" {
  source = "./modules/asg"
  project_name = var.project_name
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  instance_type = local.instance_type
  ami_id = data.aws_ssm_parameter.ami.value
  instance_sg_id = module.security_groups.instance_sg_id
  alb_sg_id = module.security_groups.alb_sg_id
  tags = local.tags
}
