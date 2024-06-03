data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = [var.aws]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "kabe-ec2" {
  ami                    = var.amiImg
  instance_type          = var.instanceType
  subnet_id              = var.publicSubnetOne
  key_name               = var.keyPair
  vpc_security_group_ids = [var.ec2VpcSecurityGroups]

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-ec2"
    }
  )
}

resource "aws_launch_configuration" "kabe-web-lc" {
  name            = "web-servers-lc"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = var.instanceType
  key_name        = var.keyPair
  security_groups = [var.webServerSecurityGroups]

  iam_instance_profile = var.ec2IntanceProfile

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y httpd
  systemctl start httpd.service
  systemctl enable httpd.service
  echo "Hello World from $(curl -s http://169.254.169.254/latest/meta-data/hostname)" > /var/www/html/index.html
EOF

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "kabe-web-asg" {
  name                = "kabe-terraform-auto-scalling-group"
  desired_capacity    = var.countTwo
  max_size            = var.countFour
  min_size            = var.countTwo
  vpc_zone_identifier = var.privateSubnets

  launch_configuration = aws_launch_configuration.kabe-web-lc.id

  target_group_arns = [var.albTargetGroupsArn]

  tag {
    key                 = "Name"
    value               = "kabe-asg-web-private-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "cloudbootcamp"
    propagate_at_launch = true
  }

  tag {
    key                 = "ProjectCode"
    value               = "cloud-bootcamp-x-skill"
    propagate_at_launch = true
  }


}

resource "aws_autoscaling_policy" "kabe-scale-up" {
  name                   = "kabe-scale-up"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.kabe-web-asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50
  }
}

resource "aws_autoscaling_attachment" "kabe-web-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.kabe-web-asg.name
  lb_target_group_arn    = var.albTargetGroupsArn
}
