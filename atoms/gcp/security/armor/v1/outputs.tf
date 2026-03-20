output "policy_id"   { description = "The Cloud Armor security policy ID."   ; value = google_compute_security_policy.this.id }
output "policy_name" { description = "The Cloud Armor security policy name." ; value = google_compute_security_policy.this.name }
