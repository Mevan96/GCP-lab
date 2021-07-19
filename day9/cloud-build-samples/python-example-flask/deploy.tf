resource "google_cloud_run_service" "run_service_flask" {
  name     = "app"
  location = "us-central1"
  template {
    spec {
      service_account_name = google_service_account.deploy.email
      containers {
        image = "gcr.io/gcp-lab-1-ym/flask-image"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_project_service.cloud_run_api]
}

output "url-flask" {
  value = "${google_cloud_run_service.run_service_flask.status[0].url}"
}