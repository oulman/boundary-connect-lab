output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.vpc.private_subnet_arns
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

output "vpc_name" {
  description = "The name of the VPC specified as argument to this module"
  value       = module.vpc.name
}

output "hcp_hvn_aws_use1_id" {
  description = "The fully qualified HCP HVN id created in AWS us-east-1"
  value       = hcp_hvn.aws_use1_hvn.id
}

output "hcp_hvn_aws_use1_hvn_id" {
  description = "The HCP HVN id created in AWS us-east-1"
  value       = hcp_hvn.aws_use1_hvn.hvn_id
}
