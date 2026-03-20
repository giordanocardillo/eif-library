output "ip_address"          { description = "The global forwarding rule IP address." ; value = google_compute_global_forwarding_rule.this.ip_address }
output "backend_bucket_name" { description = "The backend bucket resource name."       ; value = google_compute_backend_bucket.this.name }
