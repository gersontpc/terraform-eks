resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name.name
  node_group_name = format("%s-node-group", var.cluster_name)
  node_role_arn   = aws_iam_role.fargate_role.arn
  subnet_ids = [
      var.private_subnet_a.id,
      var.private_subnet_b.id
    ]

  scaling_config {
    desired_size = 3
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t2.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSFargatePodExecutionRolePolicy,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}