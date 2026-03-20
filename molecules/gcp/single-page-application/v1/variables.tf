variable "environment"       { description = "Deployment environment."              ; type = string }
variable "bucket_name"       { description = "Globally unique GCS bucket name."       ; type = string }
variable "location"          { description = "Bucket location (e.g. US, EU)."         ; type = string }
variable "cdn_name"          { description = "Base name for CDN resources."            ; type = string }
variable "armor_policy_name" { description = "Cloud Armor security policy name."      ; type = string }
variable "blocked_ip_ranges" { description = "CIDR ranges to deny (403)."             ; type = list(string) ; default = [] }
