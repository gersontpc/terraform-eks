resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.eks_cluster.name
  node_group_name = format("%s-node-group", var.cluster_name)
  node_role_arn   = aws_iam_role.fargate_role.arn
  subnet_ids = [
    var.private_subnet_a.id,
    var.private_subnet_b.id
  ]

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  instance_types = var.instance_type

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSFargatePodExecutionRolePolicy,  
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}