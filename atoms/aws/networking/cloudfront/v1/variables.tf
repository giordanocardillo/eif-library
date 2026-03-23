variable "origin_domain_name" {
  description = "The DNS domain name of the S3 bucket or custom origin."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "price_class" {
  description = "CloudFront price class."
  type        = string
  default     = "PriceClass_100"
}

variable "web_acl_id" {
  description = "ARN of the WAF WebACL to associate. Empty string disables WAF."
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "Object to return when the root URL is requested (e.g. index.html). Empty string disables default root object."
  type        = string
  default     = ""
}
