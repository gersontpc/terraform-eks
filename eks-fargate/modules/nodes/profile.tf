resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = "fargate_profile"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids = [
      var.private_subnet_a.id,
      var.private_subnet_b.id
    ]

  selector {
    namespace = "teste"
  }
}