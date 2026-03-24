terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.5"
}

resource "google_storage_bucket" "this" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = false

  dynamic "website" {
    for_each = var.website_enabled ? [1] : []
    content {
      main_page_suffix = var.index_page
      not_found_page   = var.not_found_page
    }
  }

  uniform_bucket_level_access = true

  labels = { environment = var.environment }
}

resource "google_storage_bucket_iam_member" "public_read" {
  count  = var.public_read ? 1 : 0
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
