variable "sns_subscribe_list" {
  description = "email to send notifications"
}

variable "slack_endpoint" {
  default = ""
  description = "endpoint to Slack notifications chanel"
}

variable "topic_name" {
  description = "Topic name"
}

variable "account_ids" {
  type = "list"
  default = []
  description = "List of accounts to allow publishing to SNS"
}