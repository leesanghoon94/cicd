terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

locals {
  myip = "122.37.29.17/32"
  vpc_id = "vpc-0a3cbfea0b7b300ad"
}

resource "aws_instance" "flask" {
  ami           = "ami-0443a21cb1a8f238e"
  instance_type = "t3.micro"
    associate_public_ip_address = true
    key_name = "cicd"
    vpc_security_group_ids = [aws_security_group.default_sg.id]
    subnet_id = "subnet-0b0ef75afbadfe2de"
  
  tags = {
    Name = "flask"
  }
}

resource "aws_security_group" "default_sg" {
  name        = "default_sg"
  vpc_id = local.vpc_id

  ingress {
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = [local.myip]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [local.myip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


