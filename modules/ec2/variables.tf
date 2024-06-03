variable "instanceType" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "amiImg" {
  description = "The linux ami from Singapore"
  type        = string
  default     = "ami-02453f5468b897e31"
}

variable "publicSubnetOne" {
  description = "Public subnet 1"
  type        = string
}

variable "privateSubnets" {
  description = "Two creatred private subnets"
  type        = list(string)
}

variable "ec2VpcSecurityGroups" {
  description = "ID vpc security group"
  type        = string
}

variable "keyPair" {
  description = "User Key Pair"
  type        = string
  default     = "kabeKeyPair"
}

variable "aws" {
  description = "The AWS account owner"
  default     = "amazon"
}

variable "webServerSecurityGroups" {
  description = "ID web server security group"
  type        = string
}

variable "countTwo" {
  description = "Required Number of resource instance"
  type        = number
}

variable "countFour" {
  description = "Max number of resource instance"
  type        = number
  default     = 4
}

variable "albTargetGroupsArn" {
  description = "Application load balancer group arn"
  type        = string
}

variable "ec2IntanceProfile" {
  description = "Ec2 role instance"
  type        = string
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}
