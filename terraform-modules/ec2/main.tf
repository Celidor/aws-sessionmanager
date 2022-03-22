resource "aws_iam_instance_profile" "ssm" {
  name = local.name
  role = aws_iam_role.ssm.name
}

resource "aws_iam_role" "ssm" {
  name = local.name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ssm" {
  name        = local.name
  description = "Access to Session Manager"
  policy      = templatefile("${path.module}/ssm.json.tpl", { bucket_name = var.bucket_name })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = aws_iam_policy.ssm.arn
}

# Amazon Linux2 network interface
resource "aws_network_interface" "interface_linux" {
  subnet_id       = var.linux_subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.project}-linux-${local.env}"
  }
}

# key pair required to support Windows admin password retrieval and SSH keys
# if you're only using Linux without SSH keys, delete this resource
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

# Amazon Linux2 instance
resource "aws_instance" "linux" {
  ami                  = var.amazon_linux_ami
  instance_type        = var.instance_type_linux
  iam_instance_profile = aws_iam_instance_profile.ssm.id

  # exclude line below unless SSH keys are essential
  key_name = aws_key_pair.deployer.key_name

  network_interface {
    network_interface_id = aws_network_interface.interface_linux.id
    device_index         = 0
  }

  # require IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # install Apache for port forwarding demo
  user_data = file("${path.module}/user-data-apache")

  tags = {
    Name = "${var.project}-linux-${local.env}"
  }
}

# Windows network interface
resource "aws_network_interface" "interface_windows" {
  subnet_id       = var.windows_subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.project}-windows-${local.env}"
  }
}

# Windows instance
resource "aws_instance" "windows" {

  instance_type        = var.instance_type_windows
  ami                  = var.windows_server_ami
  iam_instance_profile = aws_iam_instance_profile.ssm.id

  # required for Windows admin password retrieval
  key_name             = aws_key_pair.deployer.key_name

  network_interface {
    network_interface_id = aws_network_interface.interface_windows.id
    device_index         = 0
  }

  get_password_data      = true

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.disk_size_windows
    delete_on_termination = true
  }

  monitoring = true

  tags = {
    Name = "${var.project}-windows-${local.env}"
  }
}
