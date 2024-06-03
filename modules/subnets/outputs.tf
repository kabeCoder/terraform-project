output "kabe_public_subnet_ids" {
  value = aws_subnet.kabe-public-subnet[*].id
}

output "kabe_private_subnet_ids" {
  value = aws_subnet.kabe-private-subnet[*].id
}
