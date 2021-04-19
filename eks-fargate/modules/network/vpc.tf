resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "10.10.0.0/22"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.cluster_name
  }
}
