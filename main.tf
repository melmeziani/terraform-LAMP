#creates VPC, one public subnet, two private subnets, one EC2 instance and one MYSQL RDS instance
#aws provider
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

#network module
module "network" {
  source = "./modules/network"
}

#instance module
module "instance" {
  source = "./modules/instance"
  instance_region = var.region
  web_security_group = [module.network.web_security_group]
  public_subnet      = module.network.public_subnet
}

#rds module
module "rds" {
  source = "./modules/rds"
  db_security_group  = [module.network.db_security_group]
  private_subnet_one = module.network.private_subnet_one
  private_subnet_two = module.network.private_subnet_two
}