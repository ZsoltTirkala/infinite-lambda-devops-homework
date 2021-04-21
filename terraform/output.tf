output "s3_bucket_id" {
  description = "S3 bucket's name"
  value = aws_s3_bucket.static_website_s3_bucket.id
}

output "s3_bucket_domain_name" {
  description = "Bucket domain name"
  value = aws_s3_bucket.static_website_s3_bucket.bucket_domain_name
}

output "ec2_instance_id" {
  description = "EC2 instance id"
  value       = aws_instance.ec2_for_jenkins.id
}

output "ec2_instance_public_ip" {
  description = "EC2 instance public ip"
  value       = aws_instance.ec2_for_jenkins.public_ip
}

output "ecr_repository_url" {
  description = "AWS ECR repository's URL"
  value = aws_ecr_repository.app_ecr.repository_url
}

output "rds_id" {
  description = "RDS instance id"
  value = aws_db_instance.il_rds_postgres.id
}

output "rds_hostname" {
  description = "RDS instance address"
  value = aws_db_instance.il_rds_postgres.address
} 