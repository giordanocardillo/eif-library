variable "environment"       { description = "Deployment environment." ; type = string }
variable "policy_name"       { description = "Cloud Armor security policy name." ; type = string }
variable "blocked_ip_ranges" { description = "CIDR ranges to deny (403)." ; type = list(string) ; default = [] }
