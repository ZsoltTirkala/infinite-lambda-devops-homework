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

resource "aws_ecr_repository" "app-repository" {
  name = var.ecr_repository_name
}