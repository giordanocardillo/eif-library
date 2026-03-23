variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "cdn_name" {
  description = "Base name for all CDN and load balancer resources."
  type        = string
}

variable "bucket_name" {
  description = "GCS bucket name to back the CDN."
  type        = string
}

variable "domains" {
  description = "Domains for the Google-managed SSL certificate (e.g. [\"app.example.com\"])."
  type        = list(string)
}

variable "security_policy" {
  description = "Self-link of a Cloud Armor security policy to attach. Empty string disables Cloud Armor."
  type        = string
  default     = ""
}
