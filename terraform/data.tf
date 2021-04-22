data "aws_ssm_parameter" "rds_username" {
  name = "rds_username"
}

data "aws_ssm_parameter" "rds_password" {
  name = "rds_password"
}

data "aws_ssm_parameter" "rds_db_name" {
  name = "rds_db_name"
}
