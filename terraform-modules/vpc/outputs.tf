output "az1_private_subnet_id" {
  value = aws_subnet.subnet_priv_az1.id
}

output "security_group_id" {
  value = aws_security_group.secgroup_group.id
}