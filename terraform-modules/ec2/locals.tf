locals {
  env  = lower(terraform.workspace)
  name = "${var.project}-${local.env}"
}
