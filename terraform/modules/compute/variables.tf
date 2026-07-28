variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_endpoint" {
  description = "RDS endpoint"
  type        = string
}

variable "frontend_sg_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "backend_repository_url" {
  type = string
}

variable "frontend_repository_url" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "domain_name" {
  description = "Custom domain name for the application"
  type        = string
  default     = "marom-magic.click"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = "arn:aws:acm:us-east-1:414444871239:certificate/38e2553e-f6e7-4bef-a68d-bf1a1510599f"
}
