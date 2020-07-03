# terraform-aws-sns

[![Lint Status](https://github.com/DNXLabs/terraform-aws-sns/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-sns/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-sns)](https://github.com/DNXLabs/terraform-aws-sns/blob/master/LICENSE)

AWS SNS Application Module

This module is designed to be used with `DNXLabs/terraform-aws-monitoring`.

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
