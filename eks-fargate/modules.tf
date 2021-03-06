module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
}

module "master" {
  source = "./modules/master"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  k8s_version  = var.k8s_version

  cluster_vpc      = module.network.cluster_vpc
  private_subnet_a = module.network.private_subnet_a
  private_subnet_b = module.network.private_subnet_b
}

module "nodes" {
  source = "./modules/nodes"

  cluster_name = var.cluster_name

  eks_cluster = module.master.eks_cluster

  instance_type      = var.instance_type
  auto_scale_options = var.auto_scale_options

  private_subnet_a = module.network.private_subnet_a
  private_subnet_b = module.network.private_subnet_b
}
