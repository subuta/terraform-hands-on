terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  profile = "terraform-hands-on"
  region = "ap-northeast-1"
  version = "~> 1.7.1"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda${terraform.workspace != "default" ? "-${terraform.workspace}" : ""}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename = "./lambda/dist/terraform-hands-on.zip"
  # switch function_name based on current workspace.
  function_name = "terraform-hands-on${terraform.workspace != "default" ? "-${terraform.workspace}" : ""}"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "index.handler"
  # detect file changes by hash of zip file.
  source_code_hash = "${base64sha256(file("./lambda/dist/terraform-hands-on.zip"))}"
  runtime = "nodejs6.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}