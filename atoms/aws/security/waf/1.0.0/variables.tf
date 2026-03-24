variable "name" {
  description = "Name for the WAF WebACL."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "scope" {
  description = "Scope of the WAF WebACL. CLOUDFRONT for CloudFront distributions, REGIONAL for ALB/API Gateway."
  type        = string
  default     = "CLOUDFRONT"

  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.scope)
    error_message = "scope must be CLOUDFRONT or REGIONAL."
  }
}

variable "managed_rule_group_name" {
  description = "Name of the AWS managed rule group to attach."
  type        = string
  default     = "AWSManagedRulesCommonRuleSet"
}
