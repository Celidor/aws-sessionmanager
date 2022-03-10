module "vpc" {
  source                     = "./terraform-modules/vpc"
  project                    = var.project
  az1                        = var.az1
  vpc_cidr                   = var.vpc_cidr
  subnet_dmz_cidr_az1        = var.subnet_dmz_cidr_az1
  subnet_priv_cidr_az1       = var.subnet_priv_cidr_az1
  flow_log_retention_in_days = var.flow_log_retention_in_days
}

module "ec2" {
  source           = "./terraform-modules/ec2"
  project          = var.project
  amazon_linux_ami = var.amazon_linux_ami
  instance_type    = var.instance_type
  subnet_id        = module.vpc.az1_private_subnet_id
  bucket_name      = var.bucket_name
}
