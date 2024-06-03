variable "s3BucketArn" {
  description = "S3 bucket arn"
  type        = string
}

variable "commonTags" {
  description = "Common set of tags for resources"
  type        = map(string)
}
