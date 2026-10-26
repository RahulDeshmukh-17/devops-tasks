output "alb_dns_name" { value = module.asg.alb_dns_name }
output "vpc_id" { value = module.vpc.vpc_id }
output "instance_type" { value = local.instance_type }
