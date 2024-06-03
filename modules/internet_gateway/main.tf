resource "aws_internet_gateway" "kabe-igw" {
  vpc_id = var.vpcId

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-igw"
    }
  )
}

resource "aws_route_table" "kabe-public-rt" {

  vpc_id = var.vpcId

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kabe-igw.id
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-public-rt"
    }
  )
}

resource "aws_route_table_association" "kabe-public-association" {
  count = var.countTwo

  subnet_id      = var.publicSubnetsIds[count.index]
  route_table_id = aws_route_table.kabe-public-rt.id
}
