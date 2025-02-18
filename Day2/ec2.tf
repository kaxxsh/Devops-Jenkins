provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "this" {
  bucket = "my-no-cost-terraform-bucket"
}
