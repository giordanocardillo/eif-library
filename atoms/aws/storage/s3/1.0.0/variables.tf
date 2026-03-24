variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}

variable "versioning_enabled" {
  description = "Enable S3 versioning."
  type        = bool
  default     = false
}

variable "environment" {
  description = "Deployment environment (e.g. prod, staging, dev)."
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution allowed to access this bucket via OAC. Empty string skips bucket policy creation."
  type        = string
  default     = ""
}
