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

}