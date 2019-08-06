# == REQUIRED VARS

variable "aws_account_id" {
  description = "AWS Account where will be created new resources"
}

variable "aws_role" {
  description = "Name of role to get access"
}

variable "sns-subscribe-list" {
  default = ""
  description = "email to send notifications"
}

variable "slack_endpoint" {
  default = ""
  description = "endpoint to Slack notifications chanel"
}


variable "topic_name" {
  default = ""
  description = "Topic name"
}
