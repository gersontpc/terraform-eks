module "network" {
  source = "./modules/network"

  cluster_name  = var.cluster_name
  aws_region    = var.aws_region
}

module "master" {
  source = "./modules/master"

  cluster_name  = var.cluster_name
  aws_region    = var.aws_region
  k8s_version   = var.k8s_version

  cluster_vpc        = module.network.cluster_vpc
  private_subnet_a   = module.network.private_subnet_a
  private_subnet_b   = module.network.private_subnet_b
}