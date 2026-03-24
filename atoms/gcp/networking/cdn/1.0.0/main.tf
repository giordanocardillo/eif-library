terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.5"
}

# ── Static IP (shared by HTTP + HTTPS forwarding rules) ───────────────────────
resource "google_compute_global_address" "this" {
  name = "${var.cdn_name}-ip"
}

# ── Backend bucket (CDN enabled, optional Cloud Armor) ────────────────────────
resource "google_compute_backend_bucket" "this" {
  name            = "${var.cdn_name}-backend"
  bucket_name     = var.bucket_name
  enable_cdn      = true
  security_policy = var.security_policy != "" ? var.security_policy : null
}

# ── HTTPS ─────────────────────────────────────────────────────────────────────
resource "google_compute_url_map" "https" {
  name            = "${var.cdn_name}-https-url-map"
  default_service = google_compute_backend_bucket.this.self_link
}

resource "google_compute_managed_ssl_certificate" "this" {
  name = "${var.cdn_name}-cert"

  managed {
    domains = var.domains
  }
}

resource "google_compute_target_https_proxy" "this" {
  name             = "${var.cdn_name}-https-proxy"
  url_map          = google_compute_url_map.https.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.this.self_link]
}

resource "google_compute_global_forwarding_rule" "https" {
  name        = "${var.cdn_name}-https"
  target      = google_compute_target_https_proxy.this.self_link
  ip_address  = google_compute_global_address.this.address
  port_range  = "443"
  ip_protocol = "TCP"
}

# ── HTTP → HTTPS redirect ─────────────────────────────────────────────────────
resource "google_compute_url_map" "http_redirect" {
  name = "${var.cdn_name}-http-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "redirect" {
  name    = "${var.cdn_name}-http-proxy"
  url_map = google_compute_url_map.http_redirect.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  name        = "${var.cdn_name}-http"
  target      = google_compute_target_http_proxy.redirect.self_link
  ip_address  = google_compute_global_address.this.address
  port_range  = "80"
  ip_protocol = "TCP"
}
