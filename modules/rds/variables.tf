variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}

variable "rdsPrivateSubnet" {
  description = "Rds private subnet"
  type        = list(string)
}

variable "rdsSecurityGroup" {
  description = "Rds security group"
  type        = string
}

