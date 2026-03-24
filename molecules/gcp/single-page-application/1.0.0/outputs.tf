output "ip_address" {
  description = "Static IP for the load balancer. Point your DNS A record here."
  value       = module.cdn.ip_address
}

output "bucket_name" {
  description = "The GCS static assets bucket name."
  value       = module.gcs.bucket_name
}

output "armor_policy_name" {
  description = "The Cloud Armor security policy name."
  value       = module.armor.policy_name
}

output "ssl_certificate_id" {
  description = "The Google-managed SSL certificate ID."
  value       = module.cdn.ssl_certificate_id
}
