variable "countTwo" {
  description = "Number of route table instance"
  type        = number
}

variable "publicSubnetsIds" {
  description = "List of public subnet ids for route table assocation"
  type        = list(string)
}

variable "privateSubnetsIds" {
  description = "List of private subnet ids for route table assocation"
  type        = list(string)
}

variable "vpcId" {
  description = "ID of the VPC for nat gateway"
  type        = string
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}