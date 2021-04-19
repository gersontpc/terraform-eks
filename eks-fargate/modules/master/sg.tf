resource "aws_security_group" "cluster_master_sg" {
  name        = format("%s-cluster-master-sg", var.cluster_name)
  description = "Security Group for EKS Fargate cluster"
  vpc_id      = var.cluster_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
