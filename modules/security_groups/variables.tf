variable "vpcId" {
  description = "ID of the VPC"
  type        = string
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}
