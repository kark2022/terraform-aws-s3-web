# # Output variable definitions

# output "arn" {
#   description = "ARN of the S3 Bucket"
#   value       = aws_s3_bucket.demo-bucket.arn
# }

# output "name" {
#   description = "Name (id) of the bucket"
#   value       = aws_s3_bucket.demo-bucket.id
# }

# output "domain" {
#   description = "Domain Name of the bucket"
#   value       = aws_s3_bucket.demo-bucket.website_domain
# }

output "endpoint" {
  description = "Endpoint Information of the bucket"
  value       = aws_s3_bucket_website_configuration.demos-buckets.website_endpoint
}
