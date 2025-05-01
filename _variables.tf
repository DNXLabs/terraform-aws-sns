# variable "sns_subscribe_list" {
#   description = "email to send notifications"
# }

variable "slack_endpoint" {
  default     = ""
  description = "endpoint to Slack notifications channel (optional)"
}

variable "email" {
  default     = ""
  description = "Email address to subscribe notification to (optional)"
}

variable "sns_topic_name" {
  description = "Topic name (optional - creates SNS topic)"
  default     = ""
}

variable "sns_topic_arn" {
  description = "SNS Topic to use instead of creating one (optional)"
  default     = ""
}

variable "account_ids" {
  type        = list(string)
  default     = []
  description = "List of accounts to allow publishing to SNS (optional - only when SNS topic is created)"
}

variable "sns_kms_encryption" {
  type        = bool
  default     = false
  description = "Enabled KMS CMK encryption at rest for SNS Topic"
}

variable "lambda_runtime" {
  type = string
  default = "nodejs20.x"
  description = "Runtime for the lamdba slack function"
}