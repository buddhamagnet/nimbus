provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "instance1" {
  ami = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
  depends_on = ["aws_instance.instance2"]
}

resource "aws_instance" "instance2" {
  ami = "ami-09b89ad3c5769cca2"
  instance_type = "t2.micro"
}
