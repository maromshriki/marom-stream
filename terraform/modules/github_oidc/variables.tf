variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "role_name" {
  type    = string
  default = "GitHubActionsOIDCRole"
}

variable "backend_ecr_arn" {
  type = string
}

variable "frontend_ecr_arn" {
  type = string
}