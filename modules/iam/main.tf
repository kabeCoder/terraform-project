resource "aws_iam_role" "kabe-ec2-s3-role" {
  name = "kabe-ec2-s3-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = var.commonTags
}

resource "aws_iam_policy" "kabe-ec2-s3-policy" {
  name        = "kabe-ec2-s3-policy"
  description = "Policy for EC2 instances to access S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1702891689472",
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${var.s3BucketArn}",
        "${var.s3BucketArn}/*"
      ]
    }
  ]
}
EOF
  tags   = var.commonTags
}

resource "aws_iam_instance_profile" "kabe-ec2-profile" {
  name = "kabe-ec2-profile"

  role = aws_iam_role.kabe-ec2-s3-role.name

  tags = merge(
    var.commonTags,
    {
      Name = "kabe-ec2-profile"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attachment" {
  policy_arn = aws_iam_policy.kabe-ec2-s3-policy.arn
  role       = aws_iam_role.kabe-ec2-s3-role.name
}

