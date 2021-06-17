data "aws_iam_policy_document" "kms_policy_sns" {
  count = var.sns_kms_encryption ? 1 : 0
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    actions = ["kms:Decrypt", "kms:GenerateDataKey*"]
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com", "lambda.amazonaws.com"]
    }
    resources = ["*"]
    sid       = "allow-services-kms"
  }
}

resource "aws_kms_key" "sns" {
  count                   = var.sns_kms_encryption ? 1 : 0
  deletion_window_in_days = 7
  description             = "SNS CMK Encryption Key"
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_policy_sns[0].json
}