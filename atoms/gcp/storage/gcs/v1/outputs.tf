output "bucket_name" { description = "The GCS bucket name."     ; value = google_storage_bucket.this.name }
output "bucket_url"  { description = "The GCS bucket URL."      ; value = google_storage_bucket.this.url }
output "self_link"   { description = "The GCS bucket self link." ; value = google_storage_bucket.this.self_link }
