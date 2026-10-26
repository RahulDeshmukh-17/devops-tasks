variable "aws_region" { type = string; default = "ap-south-1" }
variable "environment" {
  type = string
  validation {
    condition = contains(["dev", "prod"], var.environment)
    error_message = "environment must be dev or prod"
  }
}
variable "project_name" { type = string; default = "devops-questionnaire" }
variable "vpc_cidr" { type = string; default = "10.20.0.0/16" }
variable "instance_type" { type = string; default = null }
variable "ssh_allowed_cidr" { type = string; default = "" }
