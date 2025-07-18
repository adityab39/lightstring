provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "lightstring_bucket" {
  bucket = "lightstring-images"
  force_destroy = true

  tags = {
    Name        = "LightString S3 Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.lightstring_bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.lightstring_bucket.id

  depends_on = [aws_s3_bucket_public_access_block.public_block] 
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::lightstring-images/*"
      }
    ]
  })
}