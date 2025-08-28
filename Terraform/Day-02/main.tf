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
