terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.5"
}

# ── Atom: GCS (static asset origin) ──────────────────────────────────────────
module "gcs" {
  source = "../../../../atoms/gcp/storage/gcs/1.0.0"

  environment = var.environment
  bucket_name = var.bucket_name
  location    = var.location
  public_read = true
}

# ── Atom: Cloud Armor (DDoS / IP filtering) ───────────────────────────────────
module "armor" {
  source = "../../../../atoms/gcp/security/armor/1.0.0"

  environment       = var.environment
  policy_name       = var.armor_policy_name
  blocked_ip_ranges = var.blocked_ip_ranges
}

# ── Atom: Cloud CDN + HTTPS load balancer ────────────────────────────────────
# depends on: gcs.bucket_name, armor.policy_self_link
module "cdn" {
  source = "../../../../atoms/gcp/networking/cdn/1.0.0"

  environment     = var.environment
  cdn_name        = var.cdn_name
  bucket_name     = module.gcs.bucket_name
  domains         = var.domains
  security_policy = module.armor.policy_self_link
}
