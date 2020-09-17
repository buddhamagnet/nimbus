provider "aws" {
  region = "eu-west-2"
}

// INPUT VARIABLE
variable "cost_centre" {
  type        = string
  description = "set the cost centre"
}

// STRING
variable "vpc_name" {
  type    = string
  default = "terraform-vpc"
}

// NUMBER
variable "year" {
  type    = number
  default = 2020
}

// BOOLEAN
variable "active" {
  default = true
}

// LIST
variable "notes" {
  type    = list(string)
  default = ["vpc", "networking"]
}

// MAP
variable "metadata" {
  type = map
  default = {
    "resource" = "vpc"
    "region"   = "eu-west-2"
  }
}

// TUPLE
variable "business_details" {
  type = tuple([string, number, bool])
  default = ["Matrix (South) Ltd", 122453626, true]
}

// OBJECT
variable "project" {
  type = object({name = string, code = number, keys = list(string)})
  default = {
    name = "project decimate"
    code = 1967
    keys = ["digital", "web"]
  }
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    provisioner = "terraform"
    cost_centre = var.cost_centre
    name        = var.vpc_name
    year        = var.year
    active      = var.active
    note_1      = var.notes[0]
    note_2      = var.notes[1]
    resource    = var.metadata["resource"]
    region      = var.metadata["region"]
    business_name = var.business_details[0]
    business_vat_number = var.business_details[1]
    business_contract_live = var.business_details[2]
    project_name = var.project.name
    project_code = var.project.code
    project_department = var.project.keys[0]
    project_squad = var.project.keys[1]
  }
}

// OUTPUTS

output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

output "vpc_default_acl" {
  value = aws_vpc.terraform_vpc.default_network_acl_id
}

output "vpc_default_route_table" {
  value = aws_vpc.terraform_vpc.default_route_table_id
}

output "vpc_default_security_group" {
  value = aws_vpc.terraform_vpc.default_security_group_id
}

