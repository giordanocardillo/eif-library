output "ip_address" {
  description = "The reserved static IP shared by the HTTP and HTTPS forwarding rules. Point your DNS A record here."
  value       = google_compute_global_address.this.address
}

output "backend_bucket_name" {
  description = "The backend bucket resource name."
  value       = google_compute_backend_bucket.this.name
}

output "ssl_certificate_id" {
  description = "The Google-managed SSL certificate ID."
  value       = google_compute_managed_ssl_certificate.this.id
}
