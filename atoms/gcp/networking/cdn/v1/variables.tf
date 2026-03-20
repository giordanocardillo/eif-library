variable "environment" { description = "Deployment environment." ; type = string }
variable "cdn_name"    { description = "Base name for CDN resources." ; type = string }
variable "bucket_name" { description = "GCS bucket name to back the CDN." ; type = string }
