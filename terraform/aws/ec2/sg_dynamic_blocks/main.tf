provider "aws" {
  region = "eu-west-2"
}

variable "ingress_rules" {
  type    = list(number)
  default = [80, 443]
}

variable "egress_rules" {
  type    = list(number)
  default = [80, 443, 25, 3306, 53, 8080]
}

resource "aws_security_group" "web" {
  name = "allow_https"
  dynamic ingress {
    iterator = port
    for_each = var.ingress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic egress {
    iterator = port
    for_each = var.egress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}

resource "aws_instance" "with_sg_dynamic_blocks" {
  ami             = "ami-09b89ad3c5769cca2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web.name]
}

output "instance" {
  value = aws_instance.with_sg_dynamic_blocks.id
}

