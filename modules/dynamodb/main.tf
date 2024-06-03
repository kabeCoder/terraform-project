resource "aws_dynamodb_table" "kabe-terraform-lock" {
  name         = "kabe-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.commonTags
}
