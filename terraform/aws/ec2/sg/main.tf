provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "web" {
  name = "allow_https"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_instance" "with_sg" {
  ami             = "ami-09b89ad3c5769cca2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web.name]
}

output "instance" {
  value = aws_instance.with_sg.id
}

