output "cluster_vpc" {
  value = aws_vpc.cluster_vpc
}

output "private_subnet_a" {
  value = aws_subnet.private_subnet_a
}

output "private_subnet_b" {
  value = aws_subnet.private_subnet_b
}

output "public_subnet_a" {
  value = aws_subnet.public_subnet_a
}

output "public_subnet_b" {
  value = aws_subnet.public_subnet_b
}