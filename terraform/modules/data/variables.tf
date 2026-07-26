variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "backend_sg_id" {}

variable "docdb_username" {
  type = string
}

variable "docdb_password" {
  type      = string
  sensitive = true
}