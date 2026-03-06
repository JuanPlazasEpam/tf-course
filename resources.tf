resource "aws_iam_policy" "cmtr_policy" {
  name        = "cmtr-gqdgh5re-iam-policy"
  description = "Custom role with limited permissions"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:GetCallerIdentity",
      "Resource": "*"
    }
  ]
}
POLICY

  tags = {}

  lifecycle {
    ignore_changes  = [policy]
    prevent_destroy = true
  }
}

output "cmtr_iam_policy_arn" {
  description = "The ARN of the IAM policy managed in this configuration"
  value       = aws_iam_policy.cmtr_policy.arn
}

