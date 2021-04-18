resource "aws_vpc" "main" {
cidr_block           = "10.10.0.0/22"
instance_tenancy     = "default"
enable_dns_hostnames = true

  tags = {
    Name = "EKS-Cluster-Fargate"
  }
}

resource "aws_subnet" "public" {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = "10.10.0.0/26"
  availability_zone        = "us-west-2a"
  map_public_ip_on_launch  = true

  tags = {
    Name = "eks-fargate-public - 10.10.0.0/26"
  }

}

resource "aws_subnet" "private" {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = "10.10.1.0/26"
  availability_zone        = "us-west-2b"
  map_public_ip_on_launch  = false

  tags = {
    Name = "eks-fargate-private - 10.10.1.0/26"
  }

}

resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.main.id
}
