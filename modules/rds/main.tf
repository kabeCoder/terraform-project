resource "aws_db_instance" "kabe-rds" {
  identifier             = "kabe-rds-instance"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  username               = var.rdsUsername
  password               = var.rdsPassword
  allocated_storage      = 20
  storage_type           = "gp2"
  engine_version         = "5.7"
  multi_az               = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.kabe-db-subnet-group.name
  vpc_security_group_ids = [var.rdsSecurityGroup]
  skip_final_snapshot    = true

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-rds"
    }
  )
}

resource "aws_db_subnet_group" "kabe-db-subnet-group" {
  name       = "kabe-db-subnet-group"
  subnet_ids = var.rdsPrivateSubnet
}

