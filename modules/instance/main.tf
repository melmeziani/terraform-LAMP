#create EC2 instance
resource "aws_instance" "my_web_instance" {
  ami                    = var.images[var.instance_region]
  instance_type          = "t2.micro"
  key_name               = "key" #make sure you have your_private_ket.pem file
  vpc_security_group_ids = var.web_security_group
  subnet_id              = var.public_subnet
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