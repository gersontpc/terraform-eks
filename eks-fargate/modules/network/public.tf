resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = format("%sa", var.aws_region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%sa", var.aws_region)
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.10.3.0/26"
  availability_zone       = format("%sb", var.aws_region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%sb", var.aws_region)
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.igw_route_table.id
}
