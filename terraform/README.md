# Terraform AWS infrastructure

Includes VPC, two public subnets across available AZs, IGW/routes, ALB, target group, launch template, ASG, security groups, dynamic Amazon Linux 2023 AMI from SSM, NGINX user data, and ALB DNS output. `dev` defaults to `t2.micro`; `prod` defaults to `t3.medium`.

## Remote state
Create the S3 state bucket and DynamoDB lock table first, enable S3 versioning/encryption/block-public-access, then copy `backend.tf.example` to `backend.tf` and replace placeholders. The requested DynamoDB locking backend setting is included; check compatibility with the Terraform version selected for execution because newer Terraform versions are moving toward S3-native lockfiles.

## Validate
Run `terraform fmt -recursive`, `terraform init`, `terraform validate`, then `terraform plan -var-file=dev.tfvars` after copying/editing the example variables file. Review costs and plan before apply. This demo uses public subnets and no NAT gateway to limit cost; production environments commonly place application instances in private subnets.
