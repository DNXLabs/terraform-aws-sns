resource "aws_sns_topic" "default" {
  count             = var.sns_topic_name != "" ? 1 : 0
  name              = var.sns_topic_name
  kms_master_key_id = var.sns_kms_encryption ? aws_kms_key.sns[0].id : null # default key does not allow cloudwatch alarms to publish
  # provisioner "local-exec" {
  #   command = "aws sns subscribe --topic-arn ${self.arn} --region ${data.aws_region.current.name} --protocol email --notification-endpoint ${var.sns_subscribe_list}"
  # }
}

resource "aws_sns_topic_policy" "default" {
  count  = var.sns_topic_name != "" && length(var.account_ids) != 0 ? 1 : 0
  arn    = aws_sns_topic.default[0].arn
  policy = data.aws_iam_policy_document.sns[0].json
}

data "aws_iam_policy_document" "sns" {
  count     = var.sns_topic_name != "" && length(var.account_ids) != 0 ? 1 : 0
  policy_id = "allow-publish-clients"

  statement {
    actions = ["SNS:Publish"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = var.account_ids
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sns_topic.default[0].arn]
    sid       = "allow-publish-clients-stmt"
  }

  statement {
    actions = ["SNS:Publish"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.default[0].arn]
    sid       = "allow-publish-event-bridge"
  }

  statement {
    actions = [
      "SNS:ListSubscriptionsByTopic"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.list_subscription_roles
    }

    resources = [
      aws_sns_topic.default.arn,
    ]

    sid = "allow-drata-to-monitor"
  }
}
