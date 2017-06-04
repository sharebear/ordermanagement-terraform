provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_user" "sample-developer" {
  name = "sample-developer"
}

resource "aws_iam_access_key" "sample-developer" {
  user = "${aws_iam_user.sample-developer.name}"
}

data "aws_iam_policy_document" "ordermanagement-api-runtime" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "${aws_dynamodb_table.orders.arn}",
    ]
  }
}

resource "aws_iam_policy" "ordermanagement-api-runtime" {
  name   = "ordermanagement-api-runtime"
  policy = "${data.aws_iam_policy_document.ordermanagement-api-runtime.json}"
}

resource "aws_iam_policy_attachment" "ordermanagement-api-runtime" {
  name       = "ordermanagement-api-runtime"
  users      = ["${aws_iam_user.sample-developer.name}"]
  policy_arn = "${aws_iam_policy.ordermanagement-api-runtime.arn}"
}

resource "aws_dynamodb_table" "orders" {
  name           = "orders"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "orderId"
  range_key      = "version"

  attribute {
    name = "orderId"
    type = "S"
  }

  attribute {
    name = "version"
    type = "N"
  }

  tags {
    Project = "ordermanagement"
  }
}

output "sample-developer.access-key-id" {
  value = "${aws_iam_access_key.sample-developer.id}"
}

output "sample-developer.secret-access-key" {
  value = "${aws_iam_access_key.sample-developer.secret}"
}
