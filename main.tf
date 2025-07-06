module "vpc" {
  source = "./modules/vpc"

  vpc_name       = var.project_name
  vpc_cidr       = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "alb" {
  source = "./modules/alb"

  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg_id      = module.security_groups.alb_sg_id
}

module "compute" {
  source            = "./modules/compute"
  ami_id            = "ami-05ffe3c48a9991133"
  instance_type     = "t3.micro"
  key_name          = "ec2-tutorial"
  private_subnets   = module.vpc.private_subnets
  target_group_arn  = module.alb.target_group_arn
  ec2_sg_id         = module.security_groups.ec2_sg_id
}