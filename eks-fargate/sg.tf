resource "aws_security_group" "testing" {
name        = "eks-fargate-sg"
description = "Security Group for EKS Fargate cluster"
vpc_id      = aws_vpc.main.id

ingress {
  description      = "HTTP from VPC"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = [aws_vpc.main.cidr_block]
}

egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "Habilita o HTTP"
  }

}
