variable "instance_name" {
  type = string

}

resource "aws_instance" "module" {
  ami           = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
  tags = {
    name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.module.public_ip
}
