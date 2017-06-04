provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_user" "sample-developer" {
  name = "sample-developer"
}

resource "aws_iam_access_key" "sample-developer" {
  user = "${aws_iam_user.sample-developer.name}"
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
