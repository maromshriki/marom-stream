variable "project_name" {
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