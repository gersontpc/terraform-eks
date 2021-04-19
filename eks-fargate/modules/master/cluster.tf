
resource "aws_eks_cluster" "eks_cluster" {

  depends_on = [aws_cloudwatch_log_group.cluster_eks]

  name                      = var.cluster_name
  version                   = var.k8s_version
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {

    security_group_ids = [
      aws_security_group.cluster_master_sg.id
    ]

    subnet_ids = [
      var.private_subnet_a.id,
      var.private_subnet_b.id
    ]
  }

  timeouts {
    delete = "30m"
  }

  tags = {
    "ENV" = var.environment
  }
}
