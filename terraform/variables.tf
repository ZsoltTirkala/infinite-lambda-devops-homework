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