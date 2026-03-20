variable "environment"              { description = "Deployment environment."              ; type = string }
variable "resource_group_name"      { description = "Azure resource group name."            ; type = string }
variable "location"                 { description = "Azure region."                         ; type = string }
variable "storage_account_name"     { description = "Storage account name (3-24 chars)."   ; type = string }
variable "account_tier"             { description = "Storage account tier."                 ; type = string ; default = "Standard" }
variable "account_replication_type" { description = "Storage replication type."             ; type = string ; default = "LRS" }
