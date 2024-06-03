output "ec2_vpc_security_groups_ids" {
  value = aws_security_group.kabe-ec2-sg.id
}

output "web_server_security_groups" {
  value = aws_security_group.kabe-web-server-sg.id
}

output "alb_security_groups" {
  value = aws_security_group.kabe-alb-sg.id
}

output "rds_security_groups" {
  value = aws_security_group.kabe-rds-sg.id
}
