variable "cluster_name" {
  default     = "eks-fargate"
  description = "Cluster name EKS"
}

variable "private_subnet_a" {}

variable "private_subnet_b" {}

variable "instance_type" {}

variable "eks_cluster" {}

variable "auto_scale_options" {}
