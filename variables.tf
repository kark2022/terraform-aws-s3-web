# Input variable definitions

variable "bucket_name" {
  description = "Name of the S3 bucket. Must be Unique across AWS"
}

variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
}