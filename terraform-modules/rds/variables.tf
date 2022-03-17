variable "project" {}
variable "subnet_id_az1" {}
variable "subnet_id_az2" {}
variable "db_security_group" {}

variable "engine" {
  description = "database type"
  default = "mysql"
}

variable "engine_version" {
  description = "database version"
  default     = "8.0"
}

variable "instance_class" {
  description = "instance type and size"
  default     = "db.t3.micro"
}

variable "username" {
  description = "database username"
  default     = "administrator"
}
