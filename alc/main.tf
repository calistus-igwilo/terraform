terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "mms-server" {
  ami           = "ami-09744628bed84e434"
  instance_type = "t2.micro"

  tags = {
    "Name" = var.instance_name
  }
}

#Create an Elastic IP
resource "aws_eip" "mms-eip" {
  vpc = true
}

#Associate EIP with EC2 Instance
resource "aws_eip_association" "demo-eip-association" {
  instance_id   = aws_instance.mms-server.id
  allocation_id = aws_eip.mms-eip.id
}

resource "aws_security_group" "mms_rds_sg" {
  name = "mms_rds_sg"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mmsdb" {
  engine                 = "mysql"
  identifier             = "mmsdb"
  allocated_storage      = 10
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.mms_rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = true

  tags = {
    "Name" = "mmsdb"
  }
}
