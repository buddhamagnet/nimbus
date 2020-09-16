provider "aws" {
  region = "eu-west-2"
}

// Number.
variable "account" {
  type    = number
  default = 100
}

// Boolean.
variable "active" {
  default = true
}

// List.
variable "engineer_tags" {
  type    = list(string)
  default = ["Buddhamagnet", "Matrix"]
}

// Map.
variable "business_tags" {
  type = map
  default = {
    Department : "Digital"
  }
}

// Tuple.
variable "code" {
  type    = tuple([string, number])
  default = ["Code", 100]
}

// Object.
variable "server" {
  type = object({ name = string, port = number })
  default = {
    name = "Server12",
    port = 5432
  }
}

// Input value.
variable "inputname" {
  type        = string
  description = "set the name of the vpc"
}

// VPC using all of the above for tags.
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name       = var.inputname
    Code       = var.account
    Active     = var.active
    Engineer   = var.engineer_tags[0]
    Company    = var.engineer_tags[1]
    Department = var.business_tags["Department"]
    ServerName = var.server.name
    ServerPort = var.server.port
    DomainName = var.code[0]
    DomainCode = var.code[1]
  }
}
