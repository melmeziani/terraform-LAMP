output "public_subnet" {
  value = aws_subnet.myvpc_public_subnet.id
}

output "private_subnet_one" {
  value = aws_subnet.myvpc_private_subnet_one.id
}

output "private_subnet_two" {
  value = aws_subnet.myvpc_private_subnet_two.id
}

output "web_security_group" {
  value = aws_security_group.web_security_group.id
}

output "db_security_group" {
  value = aws_security_group.db_security_group.id
}