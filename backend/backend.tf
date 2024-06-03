terraform {
  backend "s3" {
    bucket         = "kabe-s3-state-bucket"
    key            = "network/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "kabe-dynamodb-table"
  }
}
