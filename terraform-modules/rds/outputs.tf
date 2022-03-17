output "db_admin_username" {
  value = aws_db_instance.database.username
}

output "db_admin_password" {
  value = random_string.value.result
}

output "db_address" {
  value = aws_db_instance.database.address
}
