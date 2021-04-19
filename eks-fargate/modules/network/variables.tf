variable "aws_region" {
  default     = "us-west-2"
  type        = string
  description = "Defines region aws"
}

variable "cluster_name" {
  default     = "eks-fargate"
  description = "Cluster name EKS"
}