# add AWS provider block here
provider "aws" {
  region = "us-east-1"
}

# add AWS S3 bucket resource block here
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345-day02-tf-example"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# bucket ownership controls block here
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred" # other options are "ObjectWriter" and "BucketOwnerEnforced"
  }
}

# bucket public access block here
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# add AWS S3 acl resource block here
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [ aws_s3_bucket_ownership_controls.bucket_ownership, aws_s3_bucket_public_access_block.example ]
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read" # other options are "public-read", "public-read-write", "authenticated-read", "log-delivery-write", "bucket-owner-read", "bucket-owner-full-control", "private"
}
