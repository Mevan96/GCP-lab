resource "google_storage_bucket" "mikhalchuk-config-bucket"{
    name            = "mikhalchuk-config-bucket"
}

resource "google_service_account" "service_account" {
  account_id    = "mikhalchuk-storage"
  display_name  = "mikhalchuk-storage"
}

resource "google_service_account_key" "ym_key" {
  service_account_id = google_service_account.service_account.name
}

data "google_service_account_key" "ym_key" {
  name            = google_service_account_key.ym_key.name
}

resource "google_storage_bucket_iam_member" "policy" {
  bucket = google_storage_bucket.mikhalchuk-config-bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_storage_bucket_object" "key" {
  name = "key.json"
  content = "${base64decode(google_service_account_key.ym_key.private_key)}"
  bucket = google_storage_bucket.mikhalchuk-config-bucket.name
}