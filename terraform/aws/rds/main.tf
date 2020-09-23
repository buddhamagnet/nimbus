provider "aws" {
  region = "eu-west-2"
}

variable "username" {
  description = "The username for the DB master user"
  type        = string
}

variable "password" {
  description = "The password for the DB master user"
  type        = string
}

resource "aws_db_instance" "my_db" {
  name                = "my_database"
  identifier          = "instance"
  instance_class      = "db.t2.micro"
  engine              = "mariadb"
  engine_version      = "10.2.21"
  username            = var.username
  password            = var.password
  port                = 3306
  allocated_storage   = 20
  skip_final_snapshot = true
}
