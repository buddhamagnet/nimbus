provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    provisioner = "terraform"
  }
}

output "vpcid" {
  value = aws_vpc.terraform_vpc.id
}
