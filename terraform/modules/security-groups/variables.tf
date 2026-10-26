variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "ssh_allowed_cidr" { type = string }
variable "tags" { type = map(string) }
