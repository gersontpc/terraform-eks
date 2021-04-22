resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = format("%s-node_group", var.cluster_name)
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = [
      var.private_subnet_a.id,
      var.private_subnet_b.id
    ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  instance_types = ["t2.micro"]
}