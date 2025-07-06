output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of Public Subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of Private Subnets"
  value       = module.vpc.private_subnets
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}
