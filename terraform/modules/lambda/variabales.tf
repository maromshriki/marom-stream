variable "vpc_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_sg_id" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

variable "db_endpoint" {
  type = string
}

variable "user_secret_name" {
  type = string
}

variable "password_secret_name" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}

variable "s3_kms_key_arn" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

