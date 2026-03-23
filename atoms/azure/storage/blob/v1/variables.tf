variable "environment"              { description = "Deployment environment."              ; type = string }
variable "resource_group_name"      { description = "Azure resource group name."            ; type = string }
variable "location"                 { description = "Azure region."                         ; type = string }
variable "storage_account_name"     { description = "Storage account name (3-24 chars)."   ; type = string }
variable "account_tier"             { description = "Storage account tier."                  ; type = string ; default = "Standard" }
variable "account_replication_type" { description = "Storage replication type."              ; type = string ; default = "LRS" }
variable "static_website_enabled"   { description = "Enable static website hosting."         ; type = bool   ; default = false }
variable "index_document"           { description = "Index document for static website."     ; type = string ; default = "index.html" }
variable "error_404_document"       { description = "404 error document for static website." ; type = string ; default = "404.html" }
