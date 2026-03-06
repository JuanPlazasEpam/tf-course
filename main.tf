module "network" {
  source = "./modules/network"

  region              = var.aws_region
  project_id          = var.project_id
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  public_subnet_azs   = var.public_subnet_azs
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id           = module.network.vpc_id
  project_id       = var.project_id
  allowed_ip_range = var.allowed_ip_range
}

module "application" {
  source = "./modules/application"

  project_id           = var.project_id
  subnet_ids           = module.network.public_subnet_ids
  ssh_sg_id            = module.network_security.ssh_sg_id
  private_http_sg_id   = module.network_security.private_http_sg_id
  public_http_sg_id    = module.network_security.public_http_sg_id
  iam_instance_profile = var.iam_instance_profile
  ssh_key_name         = var.ssh_key_name
}
