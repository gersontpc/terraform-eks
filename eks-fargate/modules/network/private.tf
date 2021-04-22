resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.10.0.0/24"
  availability_zone       = format("%sa", var.aws_region)
  map_public_ip_on_launch = false

  tags = {
    Name = format("%sa", var.aws_region)
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = format("%sb", var.aws_region)
  map_public_ip_on_launch = false

  tags = {
    Name = format("%sb", var.aws_region)
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.nat.id
}