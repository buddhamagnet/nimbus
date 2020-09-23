provider "aws" {
  region = "eu-west-2"
}

data "aws_iam_policy" "admin" {
    arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "iac" {
    name = "iac"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.iac.name
  policy_arn = data.aws_iam_policy.admin.arn
}

