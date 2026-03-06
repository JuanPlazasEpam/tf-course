data "aws_iam_policy" "cmtr_policy" {
  arn = var.iam_policy_arn
}
output "cmtr_iam_policy_arn" {
  description = "The ARN of the existing IAM policy cmtr-gqdgh5re-iam-policy"
  value       = data.aws_iam_policy.cmtr_policy.arn
}

