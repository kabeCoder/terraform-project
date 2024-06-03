variable "countTwo" {
  description = "Number of subnet instance"
  type        = number
}
variable "vpcId" {
  description = "ID of the VPC for subnets"
  type        = string
}

variable "singaporeAZ1" {
  description = "Singapore Location 1"
  default     = "ap-southeast-1a"
}

variable "singaporeAZ2" {
  description = "Singapore Location 2"
  default     = "ap-southeast-1b"
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}

