output "db_server_address" {
  value = module.rds.db_server_address
}

output "web_server_address" {
  value = module.instance.web_server_address
}

