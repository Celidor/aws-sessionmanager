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

resource "aws_network_interface" "interface" {
  subnet_id = var.subnet_id

  tags = {
    Name = local.name
  }
}

# EXCLUDE RESOURCE BELOW UNLESS SSH KEYS ARE ESSENTIAL
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "instance" {
  ami                  = var.amazon_linux_ami
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm.id
  
  # EXCLUDE LINE BELOW UNLESS SSH KEYS ARE ESSENTIAL
  key_name             = aws_key_pair.deployer.key_name

  network_interface {
    network_interface_id = aws_network_interface.interface.id
    device_index         = 0
  }

  # required IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # install Apache for port forwarding demo
  user_data = file("${path.module}/user-data-apache")

  tags = {
    Name = local.name
  }
}