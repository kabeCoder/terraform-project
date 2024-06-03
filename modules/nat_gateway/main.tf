resource "aws_nat_gateway" "kabe-nat-gateway" {
  allocation_id = aws_eip.kabe-eip.id
  subnet_id     = var.publicSubnetsIds[1]
}

resource "aws_eip" "kabe-eip" {
}

resource "aws_route_table" "kabe-private-rt" {

  vpc_id = var.vpcId

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.kabe-nat-gateway.id
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-private-rt"
    }
  )
}

resource "aws_route_table_association" "kabe-private-association" {
  count = var.countTwo

  subnet_id      = var.privateSubnetsIds[count.index]
  route_table_id = aws_route_table.kabe-private-rt.id
}
