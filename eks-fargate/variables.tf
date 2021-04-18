variable "cluster_name" {
  default     = "eks-fargate"
  description = "Cluster name EKS"
}

variable "environment" {
  default     = "dev"
  description = "Environment work"
}

variable "kubernetes_version" {
  default     = "1.18"
  type        = string
  description = "Kubernetes Desired Version"
}
