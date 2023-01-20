data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-${var.amazon_linux_major_version}.*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-${var.windows_server_major_version}.*"]
  }

  owners = ["amazon"]
}
