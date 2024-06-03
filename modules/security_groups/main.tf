data "http" "my-ip" {
  url = "http://checkip.amazonaws.com/"
}

resource "aws_security_group" "kabe-ec2-sg" {
  name        = "kabe-ec2-security-group"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpcId
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${trimspace(data.http.my-ip.response_body)}/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-ec2-security-group"
    }
  )
}

resource "aws_security_group" "kabe-web-server-sg" {
  name        = "kabe-web-servers-sg"
  description = "Security group for web servers"
  vpc_id      = var.vpcId

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-web-servers-security-group"
    }
  )
}

resource "aws_security_group" "kabe-alb-sg" {
  name        = "kabe-alb-security-group"
  description = "Security group for ALB"
  vpc_id      = var.vpcId

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${trimspace(data.http.my-ip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-alb-security-group"
    }
  )
}

resource "aws_security_group" "kabe-rds-sg" {
  name        = "rds-security-group"
  description = "Security group for RDS"
  vpc_id      = var.vpcId

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-rds-security-group"
    }
  )
}
