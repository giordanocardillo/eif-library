variable "environment"    { description = "Deployment environment."                                    ; type = string }
variable "bucket_name"   { description = "Globally unique GCS bucket name."                            ; type = string }
variable "location"      { description = "Bucket location (e.g. US, EU, us-central1)."                ; type = string }
variable "public_read"   { description = "Grant allUsers objectViewer access (required for CDN use)."  ; type = bool   ; default = false }
variable "website_enabled" { description = "Enable website configuration (index/404 pages)."           ; type = bool   ; default = false }
variable "index_page"    { description = "Index page suffix for website hosting."                       ; type = string ; default = "index.html" }
variable "not_found_page" { description = "404 page for website hosting."                              ; type = string ; default = "404.html" }
