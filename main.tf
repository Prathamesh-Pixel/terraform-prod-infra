module "vpc" {
   source = "./modules/vpc"
   vpc_cidr = var.vpc_cidr
   public_subnet_cidrs = var.public_subnet_cidrs
   private_subnet_cidrs = var.private_subnet_cidrs
   availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}

module "asg" {
  source = "./modules/asg"

  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_sg_id          = module.security.ec2_sg_id
  target_group_arn   = module.alb.target_group_arn
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_username        = var.db_username
  db_password        = var.db_password
}