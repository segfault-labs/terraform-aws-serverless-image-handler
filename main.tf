data "aws_region" "current" {}

data "aws_s3_bucket" "bucket" {
  bucket = var.source_bucket
}
