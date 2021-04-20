variable "aws_profile" {
  description = "The name of the AWS profile"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS working region"
  type        = string
  default     = "eu-west-2"
}

variable "s3_bucket_name" {
  description = "The name tag's value of the S3 bucket"
  type        = string
  default     = "site-host-bucket-zs"
}

variable "s3_bucket_acl" {
  description = "S3 Bucket's ACL"
  type        = string
  default     = "public-read"
}

variable "image_id" {
  description = "EC2 ami's id"
  type        = string
  default     = "ami-096cb92bb3580c759" //  Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
}

variable "ec2_instance_type" {
  description = "EC2 free tier instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_pair" {
  description = "Key pair to the EC2 instance"
  type        = string
  default     = "il-homework-zs"
}

variable "ec2_instance_name" {
  description = "The Name tag for the EC2 instance"
  type        = string
  default     = "il-ec2-host-zs"
}

variable "ecr_repository_name" {
  description = "ECR repository's name"
  type        = string
  default     = "il-homework-zs"
}