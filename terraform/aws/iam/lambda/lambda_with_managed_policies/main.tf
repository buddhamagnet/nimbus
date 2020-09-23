provider "aws" {
  region = "eu-west-2"
}

data "aws_iam_policy" "XrayWriteOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
        "Statement": [
      {
        "Sid": "",
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "lambda.amazonaws.com"
          ]
        }
      }
    ]
  }
EOF
}

resource "aws_iam_role_policy_attachment" "xray-write-access-attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.XrayWriteOnlyAccess.arn
}
