variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}

variable "albSecurityGroupIds" {
  description = "Application Load Balancer Security Group"
}

variable "publicSubnetsIds" {
  description = "List of public subnet ids for alb"
  type        = list(string)
}

variable "vpcId" {
  description = "ID of the VPC for alb"
  type        = string
}
