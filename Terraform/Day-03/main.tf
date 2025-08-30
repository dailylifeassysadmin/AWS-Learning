# aws provider configuration
provider "aws" {
  region = "us-east-1"
}

# create a s3 bucket
    resource "aws_s3_bucket" "website_bucket" {
      bucket = "your-unique-website-bucket-name-123456-blahblah-bucketname" # change this to a unique bucket name
    }

# create a bucket and configure the website configuration for the s3 bucket
    resource "aws_s3_bucket_website_configuration" "website_config" {
      bucket = aws_s3_bucket.website_bucket.id

      index_document {
        suffix = "index.html"
      }

      error_document {
        key = "error.html"
      }
    }

# set the bucket owenership controls and public access block
    resource "aws_s3_bucket_public_access_block" "public_access_block" {
      bucket = aws_s3_bucket.website_bucket.id

      block_public_acls       = false
      block_public_policy     = false
      ignore_public_acls      = false
      restrict_public_buckets = false
    }

    resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
      bucket = aws_s3_bucket.website_bucket.id

      rule {
        object_ownership = "BucketOwnerPreferred"
      }
    }

# set the bucket policy to allow public read access to the bucket
    resource "aws_s3_bucket_policy" "bucket_policy" {
      bucket = aws_s3_bucket.website_bucket.id

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.website_bucket.arn}/*"
          }
        ]
      })
      depends_on = [ aws_s3_bucket_public_access_block.public_access_block ]
    }

# upload index.html and error.html to the s3 bucket
    # resource "aws_s3_bucket_object" "index" {
    #   bucket = aws_s3_bucket.website_bucket.id
    #   key    = "index.html"
    #   source = "index.html"
    #   acl    = "public-read"
    #   content_type = "text/html"
    #   acl    = "public-read"
    # }

    # resource "aws_s3_bucket_object" "error" {
    #   bucket = aws_s3_bucket.website_bucket.id
    #   key    = "error.html"
    #   source = "error.html"
    #   acl    = "public-read"
    #   content_type = "text/html"
    #   acl    = "public-read"
    # }

# above block is deprected, use aws_s3_object instead

    resource "aws_s3_object" "indexhtml" {
      bucket = aws_s3_bucket.website_bucket.id
      key    = "index.html"
      source = "index.html"
      content_type = "text/html"
      acl    = "public-read"
    }

    resource "aws_s3_object" "errorhtml" {
      bucket = aws_s3_bucket.website_bucket.id
      key    = "error.html"
      source = "error.html"
      content_type = "text/html"
      acl    = "public-read"
    }

# output the website endpoint
    output "website_endpoint" {
      value = aws_s3_bucket_website_configuration.website_config.website_endpoint
    }
