data "aws_ssm_parameter" "rds_username" {
  name = "rds_username"
}

data "aws_ssm_parameter" "rds_password" {
  name = "rds_password"
}

data "aws_ssm_parameter" "rds_db_name" {
  name = "rds_db_name"
}

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
  description = "EC2 ami's id (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type)"
  type        = string
  default     = "ami-096cb92bb3580c759"
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

variable "rds_engine" {
  description = "RDS engine"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "12.5"
}
variable "rds_instance_class" {
  description = "The class of RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "rds_identifier" {
  description = "Name of the RDS instance"
  type        = string
  default     = "il-postgres-zs"
}

variable "rds_allocated_storage" {
  description = "The storage of RDS"
  type        = string
  default     = "20"
}

variable "rds_max_allocated_storage" {
  description = "Maximum storage of RDS"
  type        = string
  default     = "21"
}