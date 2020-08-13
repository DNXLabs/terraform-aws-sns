# terraform-aws-sns

Terraform-aws-sns is a module that creates an AWS SNS Application Module.

This module requires:
 - Terraform Version >=0.12.20

This modules creates the following resources:
 
 - Simple Notification Services (SNS) topic
 - Provides a Lambda Function resource. Lambda allows you to trigger execution of code in response to events in AWS, enabling serverless backend solutions. 
 - Gives an external source (like a CloudWatch Event Rule, SNS, or S3) permission to access the Lambda function. In our case is SNS
 - An SNS topic policy resource

[![Lint Status](https://github.com/DNXLabs/terraform-aws-sns/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-sns/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-sns)](https://github.com/DNXLabs/terraform-aws-sns/blob/master/LICENSE)




<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | List of accounts to allow publishing to SNS | `list(string)` | `[]` | no |
| slack\_endpoint | endpoint to Slack notifications chanel | `string` | `""` | no |
| topic\_name | Topic name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_sns\_topic\_arn | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-sns/blob/master/LICENSE) for full details.
