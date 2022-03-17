resource "random_string" "value" {
  length = 25
  special = true
  override_special = "-"
}

resource "aws_db_subnet_group" "database" {
  name       = "${var.project}-db-${local.env}"
  subnet_ids = [var.subnet_id_az1, var.subnet_id_az2]

  tags = {
    Name = "${var.project}-db-${local.env}"
  }
}

resource "aws_db_instance" "database" {
  allocated_storage      = 10
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = "${replace(title(replace(var.project, "-", " ")), " ", "")}${title(local.env)}"
  username               = var.username
  password               = random_string.value.result
  db_subnet_group_name   = aws_db_subnet_group.database.name
  vpc_security_group_ids = [var.db_security_group]
  multi_az               = false
  skip_final_snapshot    = true
}