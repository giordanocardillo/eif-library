output "policy_id" {
  description = "The Cloud Armor security policy ID."
  value       = google_compute_security_policy.this.id
}

output "policy_name" {
  description = "The Cloud Armor security policy name."
  value       = google_compute_security_policy.this.name
}

output "policy_self_link" {
  description = "The Cloud Armor security policy self link (use this to attach to backend resources)."
  value       = google_compute_security_policy.this.self_link
}
