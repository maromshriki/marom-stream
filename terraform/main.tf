terraform {
  required_version = ">= 1.6.0"
}

module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"

  vpc_id        = module.network.vpc_id
  s3_bucket_arn = module.data.bucket_arn

}

module "data" {
  source = "./modules/data"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  backend_sg_id      = module.security.backend_sg_id
  docdb_username     = var.docdb_username
  docdb_password     = var.docdb_password
}

module "ecr" {
  source = "./modules/ecr"
}

module "compute" {
  source = "./modules/compute"

  vpc_id = module.network.vpc_id

  alb_sg_id             = module.security.alb_sg_id
  frontend_sg_id        = module.security.frontend_sg_id
  backend_sg_id         = module.security.backend_sg_id
  instance_profile_name = module.security.instance_profile_name

  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

  db_endpoint             = module.data.db_endpoint
  s3_bucket_name          = module.data.bucket_name
  backend_repository_url  = module.ecr.backend_repository_url
  frontend_repository_url = module.ecr.frontend_repository_url

  domain_name         = var.domain_name
  acm_certificate_arn = var.acm_certificate_arn

}

resource "aws_wafv2_web_acl_association" "app" {
  resource_arn = module.compute.alb_arn
  web_acl_arn  = module.security.waf_web_acl_arn
}

module "github_oidc" {

  source = "./modules/github_oidc"

  github_owner = "maromshriki"

  github_repo      = "marom-stream"
  backend_ecr_arn  = module.ecr.backend_repository_arn
  frontend_ecr_arn = module.ecr.frontend_repository_arn
}