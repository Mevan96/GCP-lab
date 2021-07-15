resource "google_sql_database" "database" {
  project  = "gcp-lab-1-ym"
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "google_sql_user" "users" {
  project  = "gcp-lab-1-ym"
  name     = "ym"
  instance = google_sql_database_instance.instance.name
  password = random_password.password.result
}