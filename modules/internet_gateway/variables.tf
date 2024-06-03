variable "countTwo" {
  description = "Number of route table instance"
  type        = number
}

variable "vpcId" {
  description = "ID of the VPC for internet gateway"
  type        = string
}

variable "publicSubnetsIds" {
  description = "List of public subnet ids for route table assocation"
  type        = list(string)
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}
