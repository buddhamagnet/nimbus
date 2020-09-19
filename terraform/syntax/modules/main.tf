provider "aws" {
  region = "eu-west-2"
}

module "ec2_module" {
  source        = "./ec2"
  instance_name = "modularized"
}

output "instance" {
  value = module.ec2_module.public_ip
}

