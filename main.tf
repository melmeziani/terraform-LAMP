#creates VPC, one public subnet, two private subnets, one EC2 instance and one MYSQL RDS instance
#aws provider
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

#create EC2 instance
resource "aws_instance" "my_web_instance" {
  ami                    = var.images[var.region]
  instance_type          = "t2.micro"
  key_name               = "key" #make sure you have your_private_ket.pem file
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  subnet_id              = aws_subnet.myvpc_public_subnet.id
  tags = {
    Name = "my_web_instance"
  }
  volume_tags = {
    Name = "my_web_instance_volume"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/www/html/", #install apache, mysql client, php
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo service httpd start",
      "sudo usermod -a -G apache ec2-user",
      "sudo chown -R ec2-user:apache /var/www",
      "sudo yum install -y mysql php php-mysql",
    ]
  }
  provisioner "file" {
    source = "index.php" #copy the index file form local to remote

    destination = "/var/www/html/index.php"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    host     = aws_instance.my_web_instance.public_dns

    #copy <your_private_key>.pem to your local instance home directory
    #restrict permission: chmod 400 <your_private_key>.pem
    private_key = file("/Users/melmeziani/.ssh/key.pem")
  }
}

#create aws rds subnet groups
resource "aws_db_subnet_group" "my_database_subnet_group" {
  name       = "mydbsg"
  subnet_ids = [aws_subnet.myvpc_private_subnet_one.id, aws_subnet.myvpc_private_subnet_two.id]
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
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
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

