variable "project" {
  description = "abbreviation for the project, forms first part of resource names"
  default     = "aws-ec2"
}

variable "region" {
  default = "eu-west-1"
}

variable "az1" {
  default = "eu-west-1a"
}

variable "amazon_linux_ami" {
  description = "AMI for Amazon Linux 2 Kernel 4.x in default region"
  default     = "ami-01ddabedd99da311e"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "vpc_cidr" {
  default = "10.245.0.0/16"
}

variable "subnet_dmz_cidr_az1" {
  default = "10.245.1.0/24"
}

variable "subnet_priv_cidr_az1" {
  default = "10.245.2.0/24"
}

variable "flow_log_retention_in_days" {
  description = "Days to retain Flow Logs in CloudWatch"
  default     = "30"
}

variable "bucket_name" {
  description = "Bucket Name used for Session Manager logging"
}

variable "key_name" {
  description = "Engineer name, e.g. john-smith"
}

variable "public_key" {
  description = "SSH public key used to build instance to allow login from laptop"
}