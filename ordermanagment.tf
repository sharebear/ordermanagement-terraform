provider "aws" {
  region = "eu-west-1"
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
