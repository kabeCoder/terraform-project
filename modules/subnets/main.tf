resource "aws_subnet" "kabe-public-subnet" {
  count                   = var.countTwo
  vpc_id                  = var.vpcId
  cidr_block              = element(["10.0.0.0/20", "10.0.16.0/20"], count.index)
  availability_zone       = element([var.singaporeAZ1, var.singaporeAZ2], count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-public-subnet-${count.index + 1}-${element([var.singaporeAZ1, var.singaporeAZ2], count.index)}"
    }
  )
}

resource "aws_subnet" "kabe-private-subnet" {
  count             = 4
  vpc_id            = var.vpcId
  cidr_block        = element(["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", "10.0.176.0/20"], count.index)
  availability_zone = element([var.singaporeAZ1, var.singaporeAZ2], count.index)

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-private-subnet-${count.index + 1}-${element([var.singaporeAZ1, var.singaporeAZ2], count.index)}"
    }
  )
}
