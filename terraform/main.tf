module "s3" {
  source        = "./modules/s3"
  bucket_prefix = var.bucket_prefix
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source         = "./modules/ec2"
  ami_id         = "ami-0c02fb55956c7d316"
  instance_type  = "t3.micro"
  subnet_id      = module.vpc.public_subnet_id
  security_group = module.vpc.ec2_sg_id
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  ec2_sg_id          = module.vpc.ec2_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}