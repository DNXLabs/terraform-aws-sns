# terraform-aws-sns

[![Lint Status](https://github.com/DNXLabs/terraform-aws-sns/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-sns/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-sns)](https://github.com/DNXLabs/terraform-aws-sns/blob/master/LICENSE)

This is a module that creates an AWS SNS Application Module and it was designed to be used with `DNXLabs/terraform-aws-monitoring`.

The following resources will be created:
 
 - Simple Notification Services (SNS) topic
 - Provides a Lambda Function resource. Lambda allows you to trigger execution of code in response to events in AWS, enabling serverless backend solutions. The Lambda function details and documentation are available on `DNXLabs/lambda-cloudwatch-slack`.
 - Gives an external source (like a CloudWatch Event Rule, SNS, or S3) permission to access the Lambda function. In our case is SNS
 - An SNS topic policy resource

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | List of accounts to allow publishing to SNS (optional - only when SNS topic is created) | `list(string)` | `[]` | no |
| email | Email address to subscribe notification to (optional) | `string` | `""` | no |
| lambda\_runtime | Runtime for the lamdba slack function | `string` | `"nodejs20.x"` | no |
| slack\_endpoint | endpoint to Slack notifications channel (optional) | `string` | `""` | no |
| sns\_kms\_encryption | Enabled KMS CMK encryption at rest for SNS Topic | `bool` | `false` | no |
| sns\_topic\_arn | SNS Topic to use instead of creating one (optional) | `string` | `""` | no |
| sns\_topic\_name | Topic name (optional - creates SNS topic) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_sns\_topic\_arn | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-sns/blob/master/LICENSE) for full details.
