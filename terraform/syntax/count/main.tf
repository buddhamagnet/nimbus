provider "aws" {
  region = "eu-west-2"
}

variable "instance_names" {
  type = list(string)
  default = ["instance1", "instance2", "instance3"]
}

resource "aws_instance" "dynamic" {
  ami = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
  count = length(var.instance_names)
  tags = {
    name = var.instance_names[count.index]
  }
}

resource "aws_instance" "fleet" {
  ami = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
  count = 3
}

output "public_ip_fleet" {
  value = aws_instance.fleet.*.public_ip
}

output "public_ip_dynamic" {
  value = aws_instance.fleet.*.public_ip
}

