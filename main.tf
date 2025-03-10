# Create S3 Bucket resource
resource "aws_s3_bucket" "demos_buckets" {
  bucket = var.bucket_name
  force_destroy = true
}

# Configure bucket acl
resource "aws_s3_bucket_ownership_controls" "demos_buckets" {
  bucket = aws_s3_bucket.demos_buckets.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "demos_buckets" {
  bucket = aws_s3_bucket.demos_buckets.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "demos_buckets" {
  depends_on = [
    aws_s3_bucket_ownership_controls.demos_buckets,
    aws_s3_bucket_public_access_block.demos_buckets,
  ]

  bucket = aws_s3_bucket.demos_buckets.id
  acl    = "public-read"
}

# Define website configuration
resource "aws_s3_bucket_website_configuration" "demos_buckets" {
  bucket = aws_s3_bucket.demos_buckets.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
# Configure bucket policy
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.demos_buckets.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.demos_buckets.id}/*"
            ]
        }
    ]
}
EOF
}

# create an S3 object for the webapp
resource "aws_s3_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.demos_buckets.id
  content      = file("${path.module}/index.html")
  content_type = "text/html"
}
