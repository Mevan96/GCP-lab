resource "google_project_iam_custom_role" "custom-role" {
  role_id     = "customRole"
  title       = "get"
  description = "get files from all bucket and info abou VMs in project"
  permissions = ["storage.buckets.get", "compute.instances.get",
   "storage.buckets.list", "compute.instances.list"]
}

resource "google_service_account" "mikhalchuk-gke" {
  account_id    = "mikhalchuk-gke"
  display_name  = "mikhalchuk-gke"
}

resource "google_project_iam_member" "mikhalchuk-gke" {
  role   = google_project_iam_custom_role.custom-role.id
  member = "serviceAccount:${google_service_account.mikhalchuk-gke.email}"
}