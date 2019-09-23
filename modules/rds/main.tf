#create aws rds subnet groups
resource "aws_db_subnet_group" "my_database_subnet_group" {
  name       = "mydbsg"
  subnet_ids = [var.private_subnet_one, var.private_subnet_two]
  tags = {
    Name = "my_database_subnet_group"
  }
}

#create aws mysql rds instance
resource "aws_db_instance" "my_database_instance" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  port                   = 3306
  vpc_security_group_ids = var.db_security_group
  db_subnet_group_name   = aws_db_subnet_group.my_database_subnet_group.name
  name                   = "mydb"
  identifier             = "mysqldb"
  username               = "myuser"
  password               = "mypassword"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  tags = {
    Name = "my_database_instance"
  }
}
