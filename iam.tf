locals {
  project_tag = "cmtr-gqdgh5re"
  bucket_name = "cmtr-gqdgh5re-bucket-1772736835"
}

resource "aws_iam_group" "this" {
  name = "cmtr-gqdgh5re-iam-group"
}

resource "aws_iam_policy" "this" {
  name        = "cmtr-gqdgh5re-iam-policy"
  description = "Write access to a specific S3 bucket"

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = local.bucket_name
  })

  tags = {
    Project = local.project_tag
  }
}

resource "aws_iam_role" "this" {
  name = "cmtr-gqdgh5re-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = local.project_tag
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "cmtr-gqdgh5re-iam-instance-profile"
  role = aws_iam_role.this.name

  tags = {
    Project = local.project_tag
  }
}

