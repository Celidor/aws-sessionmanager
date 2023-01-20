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

variable "az2" {
  default = "eu-west-1b"
}

variable "amazon_linux_major_version" {
  description = "major version of Amazon Linux"
  default     = "5.10-hvm-2.0"
}

variable "windows_server_major_version" {
  description = "major version of Windows Server"
  default     = "2022-English-Full-Base-2023"
}

variable "instance_type_linux" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "instance_type_windows" {
  description = "Instance type"
  default     = "t3.small"
}

variable "volume_type" {
  description = "ec2 volume type"
  default     = "gp3"
}

variable "disk_size_windows" {
  description = "root disk size for Windows"
  default     = "30"
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

variable "subnet_dmz_cidr_az2" {
  default = "10.245.3.0/24"
}

variable "subnet_priv_cidr_az2" {
  default = "10.245.4.0/24"
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