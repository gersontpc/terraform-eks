resource "aws_cloudwatch_log_group" "cluster_eks" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

  tags = {
    Name = format("%s-logs", var.cluster_name)
  }
}