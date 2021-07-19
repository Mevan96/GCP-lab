resource "google_service_account" "deploy" {
  account_id   = "deploy"
  display_name = "Deploy"
}

resource "google_project_iam_member" "storage-deploy-admin" {
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.deploy.email}"
}

resource "google_project_iam_member" "datastore-deploy-user" {
  role   = "roles/datastore.user"
  member = "serviceAccount:${google_service_account.deploy.email}"
}

resource "google_project_iam_member" "memcache-deploy-admin" {
  role   = "roles/memcache.admin"
  member = "serviceAccount:${google_service_account.deploy.email}"
}

resource "google_project_iam_member" "cloudsql-deploy-admin" {
  role   = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.deploy.email}"
}

data "google_iam_policy" "all_invoke" {
  binding {
    role    = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth_flask" {
  location    = google_cloud_run_service.run_service_flask.location
  project     = google_cloud_run_service.run_service_flask.project
  service     = google_cloud_run_service.run_service_flask.name
  policy_data = data.google_iam_policy.all_invoke.policy_data
}