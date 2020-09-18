provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "web" {
  name = "allow_https"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_instance" "apache" {
  ami = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web.name]
  user_data     = file("install-apache.sh")
  tags = {
    Name  = "Terraform"
    Batch = "5AM"
  }
}

output "public_ip" {
  value = aws_instance.apache.public_ip
}