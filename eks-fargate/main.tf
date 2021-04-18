
resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name

  version = var.kubernetes_version

  role_arn = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]
  }

  timeouts {
    delete = "30m"
  }

  tags = {
  "ENV" = "dev"
  }
}
