resource "aws_s3_bucket" "kabe-s3-bucket" {
  bucket = "kabe-s3-bucket"

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-s3-bucket"
    }
  )
}

resource "aws_s3_bucket" "kabe-s3-state-bucket" {
  bucket = "kabe-s3-state-bucket"

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-s3-state-bucket"
    }
  )
}

resource "aws_vpc_endpoint" "kabe-s3-endpoint" {
  vpc_id       = var.vpcId
  service_name = "com.amazonaws.ap-southeast-1.s3"
  tags = merge(
    var.commonTags,
    {
      Name = "kabe-s3-gateway-endpoint"
    }
  )
}

resource "aws_s3_bucket_lifecycle_configuration" "kabe-s3-lifecycle-config" {
  bucket = aws_s3_bucket.kabe-s3-bucket.id

  rule {
    id = "expire-old-objects"

    expiration {
      days = 30
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "kabe-s3-bucket-policy" {
  bucket = aws_s3_bucket.kabe-s3-bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Policy1415115909152",
  "Statement": [
    {
      "Sid": "Access-to-specific-VPCE-only",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::kabe-s3-bucket/*"],
      "Condition": {
        "StringEquals": {
          "aws:sourceVpce": "${aws_vpc_endpoint.kabe-s3-endpoint.id}"
        }
      }
    }
  ]
}
POLICY
}


