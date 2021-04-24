terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "test_subneta" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "test-subnet"
  }
}

resource "aws_subnet" "test_subnetb" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "test-subnet"
  }
}

resource "aws_network_interface" "test_interface" {
  subnet_id   = aws_subnet.test_subneta.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_internet_gateway" "test_internet_gateway" {
  vpc_id = aws_vpc.test_vpc.id
  
  tags = {
    Name = "main"
  }
}

resource "aws_db_subnet_group" "test_rds_subnet" {
  name       = "test-rds-subnet"
  subnet_ids = [aws_subnet.test_subneta.id,aws_subnet.test_subnetb.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_s3_bucket" "static_website_s3_bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_bucket_acl
  force_destroy = true
  policy = file("policy.json")
  tags = {
    Name = var.s3_bucket_name
  }

  website {
    index_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_instance" "ec2_for_jenkins" {
  ami           = var.image_id
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_pair
  network_interface {
    network_interface_id = aws_network_interface.test_interface.id
    device_index         = 0
  }
  tags = {
    Name = var.ec2_instance_name
  }
}

resource "aws_eip" "elastic" {
  instance = aws_instance.ec2_for_jenkins.id
  vpc      = true
}

resource "aws_ecr_repository" "app_ecr" {
  name = var.ecr_repository_name
}

resource "aws_db_instance" "il_rds_postgres" {
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_instance_class
  identifier            = var.rds_identifier
  name                  = data.aws_ssm_parameter.rds_db_name.value
  username              = data.aws_ssm_parameter.rds_username.value
  password              = data.aws_ssm_parameter.rds_password.value
  db_subnet_group_name  = aws_db_subnet_group.test_rds_subnet.name
  skip_final_snapshot   = true
  publicly_accessible   = true
}
