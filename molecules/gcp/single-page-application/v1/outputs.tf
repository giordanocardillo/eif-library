output "cdn_ip_address"    { description = "The CDN global forwarding rule IP address." ; value = module.cdn.ip_address }
output "bucket_name"       { description = "The GCS static assets bucket name."         ; value = module.gcs.bucket_name }
output "armor_policy_name" { description = "The Cloud Armor security policy name."      ; value = module.armor.policy_name }
