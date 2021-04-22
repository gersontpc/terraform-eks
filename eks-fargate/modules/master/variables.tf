variable "aws_region" {
  default     = "us-west-2"
  type        = string
  description = "Defines region aws"
}

variable "cluster_name" {
  default     = "eks-fargate"
  description = "Cluster name EKS"
}

variable "environment" {
  default     = "dev"
  description = "Environment work"
}

variable "k8s_version" {
  default     = "1.18"
  type        = string
  description = "Kubernetes Desired Version"
}

variable "cluster_vpc" {}

variable "private_subnet_a" {}

variable "private_subnet_b" {}