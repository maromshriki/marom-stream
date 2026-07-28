variable "project_name" {
  type    = string
  default = "maromstream-project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "docdb_username" {
  type = string
}

variable "docdb_password" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  description = "Custom domain name for the app"
  type        = string
  default     = "marom-magic.click"
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS on the ALB"
  type        = string
  default     = "arn:aws:acm:us-east-1:414444871239:certificate/38e2553e-f6e7-4bef-a68d-bf1a1510599f"
}