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

resource "aws_s3_bucket" "static_website_s3_bucket" {
  bucket = var.s3_bucket_name
  acl    = var.s3_bucket_acl
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
  tags = {
    Name = var.ec2_instance_name
  }
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
  skip_final_snapshot   = true
  publicly_accessible   = true
}