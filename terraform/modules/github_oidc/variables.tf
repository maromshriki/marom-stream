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