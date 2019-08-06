provider "aws" {
  region = "ap-southeast-2"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_role}"
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_role}"
  }
}
